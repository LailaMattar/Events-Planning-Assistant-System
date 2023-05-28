import 'dart:collection';

import 'package:event_planning/blocs/CreateBookBloc.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/posts/booking.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'error_page.dart';
import 'loading_page.dart';

class TableMultiExample extends StatefulWidget {
  final int vendorId;
  final Post post1;
  final Book Data1;
  final String from1;
  final int copoun1;
  TableMultiExample(
      {required this.post1,
      required this.Data1,
      required this.from1,
      required this.copoun1,
      required this.vendorId});
  @override
  _TableMultiExampleState createState() => _TableMultiExampleState(
      post: this.post1,
      Data: this.Data1,
      from: this.from1,
      copoun: copoun1,
      vendorId: vendorId);
}

class _TableMultiExampleState extends State<TableMultiExample> {
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  late CreateBookBloc _bloc;
  int vendorId;
  late Book Data;
  late String from;
  late Post post;
  late int copoun;
  _TableMultiExampleState(
      {required this.vendorId,
      required this.post,
      required this.Data,
      required this.from,
      required this.copoun});

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  Set<DateTime> _selectedDaysBook = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  DateTime? _selectedDay;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    // _selectedDays.add(DateTime.utc(2022,8,16));
    // _selectedDays.add(DateTime.utc(2022,8,20));
    _bloc = CreateBookBloc();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    // Implementation example
    // Note that days are in selection order (same applies to events)
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      debugPrint("focus : " + focusedDay.toString());
      // Update values in a Set
      if (_selectedDaysBook.contains(selectedDay)) {
        var snackBar = const SnackBar(content: Text('this day is booked'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (_selectedDays.contains(selectedDay)) {
        debugPrint("trueeee");
        _selectedDays.remove(selectedDay);
      } else {
        if (_selectedDay == null) {
          _selectedDay = selectedDay;
          _selectedDays.add(selectedDay);
        } else {
          _selectedDays.add(selectedDay);
          _selectedDays.remove(_selectedDay);
          _selectedDay = selectedDay;
        }
        // _selectedDays.add(selectedDay);
      }
    });

    // _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select date'),
      ),
      body: StreamBuilder<ApiResponse<Book>>(
        stream: _bloc.theStream,
        builder: (context, snapshot) {
          debugPrint('inside stream builder');
          if (snapshot.hasError) {
            debugPrint('error');
          } else if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                debugPrint('loading profile');
                return const LoadingPage();
              case Status.COMPLETED:
                _bloc.dispose();
                debugPrint('complete profile');
                for (int i = 0; i < snapshot.data!.data.days.length; i++) {
                  debugPrint("daysss2");
                  String date = snapshot.data!.data.days[i];
                  String year = date.substring(0, date.indexOf('-'));
                  date = date.substring(5, 12);
                  String month = date.substring(0, date.indexOf('-'));
                  date = date.substring(3, 7);
                  String day = date.substring(0, 3);
                  debugPrint(year);
                  debugPrint(month);
                  debugPrint(day);
                  _selectedDays.add(DateTime.utc(
                      int.parse(year), int.parse(month), int.parse(day)));
                  _selectedDaysBook.add(DateTime.utc(
                      int.parse(year), int.parse(month), int.parse(day)));
                }
                return Column(
                  children: [
                    TableCalendar<Event>(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      // eventLoader: _getEventsForDay,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      selectedDayPredicate: (day) {
                        // Use values from Set to mark multiple days as selected
                        return _selectedDays.contains(day);
                      },
                      onDaySelected: _onDaySelected,
                      // onFormatChanged: (format) {
                      //   if (_calendarFormat != format) {
                      //     setState(() {
                      //       _calendarFormat = format;
                      //     });
                      //   }
                      // },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: BigButton(
                          title: "select",
                          color: pink,
                          Textcolor: Colors.white,
                          onTap: () {
                            Navigator.push(
                                context,
                                SlideRightRoute(
                                    page: BookService(
                                  vendorId: vendorId,
                                  Data1: Data,
                                  post1: post,
                                  from1: from,
                                  copoun1: copoun,
                                  dateTime: _selectedDay!,
                                  totalPrice: 0.0,
                                )));
                          }),
                    ),
                  ],
                );
              case Status.ERROR:
                debugPrint('error profile');
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  var snackBar = const SnackBar(content: Text('Error'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });

                return ErrorPage(
                  onRetryPressed: () => _bloc.getBookDays(vendorId),
                );
            }
          }
          // debugPrint('outside $snapshot');
          _bloc.getBookDays(vendorId);
          return Container();
        },
      ),
    );
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
