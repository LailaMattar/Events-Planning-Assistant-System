import 'dart:collection';

import 'package:event_planning/models/vendor_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../test.dart';

class CalenderView extends StatefulWidget {
  final VendorProfile vendorProfile;
  const CalenderView({Key? key,required this.vendorProfile}) : super(key: key);

  @override
  _CalenderViewState createState() => _CalenderViewState(vendorProfile: this.vendorProfile);
}

class _CalenderViewState extends State<CalenderView> {
  VendorProfile vendorProfile;
  _CalenderViewState({required this.vendorProfile});
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  DateTime _focusedDay = DateTime.now();
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);


  @override
  void initState() {
    for(int i = 0 ; i < vendorProfile.days.length ; i ++){
      debugPrint("daysss");
      String date = vendorProfile.days[i];
      String year = date.substring(0,date.indexOf('-'));
      date = date.substring(5,12);
      String month = date.substring(0,date.indexOf('-'));
      date = date.substring(3,7);
      String day = date.substring(0,3);
      debugPrint(year);
      debugPrint(month);
      debugPrint(day);
      _selectedDays.add(DateTime.utc(int.parse(year),int.parse(month),int.parse(day)));
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    // Implementation example
    // Note that days are in selection order (same applies to events)
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        selectedDayPredicate: (day) {
          // Use values from Set to mark multiple days as selected
          return _selectedDays.contains(day);
        },
      ),
    );
  }
}
