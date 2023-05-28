import 'package:event_planning/blocs/create_event_bloc.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/home_page.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEventPage extends StatefulWidget {
  final String eventTimeString;
  final String eventDateString;
  final String eventName;
  const CreateEventPage(
      {Key? key,
      required this.eventTimeString,
      required this.eventDateString,
      required this.eventName})
      : super(key: key);
  @override
  _CreateEventPageState createState() => _CreateEventPageState(
      eventDateString: eventDateString,
      eventName: eventName,
      eventTimeString: eventTimeString);
}

class _CreateEventPageState extends State<CreateEventPage> {
  final TextEditingController _eventNameController = TextEditingController();
  TimeOfDay? eventTime;
  String eventTimeString;
  String eventDateString;
  String eventName;
  _CreateEventPageState(
      {required this.eventName,
      required this.eventDateString,
      required this.eventTimeString});
  DateTime selectedDate = DateTime.now();
  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;
  late CreateEventBloc _bloc;

  @override
  void initState() {
    _bloc = CreateEventBloc();
    if (eventName != " ") {
      _eventNameController.text = eventName;
    }
    if (eventTimeString == " ") {
      eventTimeString = "Event Time";
    }
    if (eventDateString == " ") {
      eventDateString = "Event Date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Column(
                  children: [
                    Container(
                      width: 250.h,
                      height: 250.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/create_event.jpg',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 30.h),
                    child: Text(
                      'Planning your event',
                      style: TextStyle(
                        color: const Color(0xff787878),
                        fontSize: 20.r,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: TextFormField(
                    controller: _eventNameController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 15.r),
                    decoration: InputDecoration(
                      hintText: 'Event Name',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.h),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10.h)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10.h)),
                      ),
                      hintStyle: const TextStyle(color: Color(0xff919191)),
                      filled: true,
                      fillColor: const Color(0xffE9EDF2),
                      contentPadding: EdgeInsets.all(12.h),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now().subtract(Duration(days: 0)),
                          lastDate: DateTime(2100));
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                          eventDateString =
                              "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xffE9EDF2),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Text(
                        eventDateString,
                        style: TextStyle(
                            fontSize: 15.r, color: const Color(0xff919191)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: InkWell(
                    onTap: () async {
                      debugPrint('from');
                      TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 12, minute: 00));
                      if (newTime != null) {
                        eventTime = newTime;
                        if (eventTime!.hour < 10) {
                          eventTimeString = '0${eventTime!.hour}:';
                        } else {
                          eventTimeString = '${eventTime!.hour}:';
                        }
                        if (eventTime!.minute < 10) {
                          eventTimeString += '0${eventTime!.minute}';
                        } else {
                          eventTimeString += '${eventTime!.minute}';
                        }
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xffE9EDF2),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Text(
                        eventTimeString,
                        style: TextStyle(
                            fontSize: 15.r, color: const Color(0xff919191)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.h),
                    child: BigButton(
                        title: eventName == " " ? "Create" : 'Update',
                        Textcolor: Colors.white,
                        color: pink,
                        onTap: () {
                          visibleStream = true;
                          updateBloc = true;
                          showError = true;
                          setState(() {});
                          MyEvent event = MyEvent(_eventNameController.text,
                              eventDateString, eventTimeString);
                          _bloc.createEvent(event);
                        })),
                Visibility(
                  visible: visibleStream,
                  child: StreamBuilder<ApiResponse<MyEvent>>(
                    stream: _bloc.theStream,
                    builder: (context, snapshot) {
                      debugPrint('inside stream builder');
                      // debugPrint('status code: ${snapshot.data!.status}');
                      if (!updateBloc) {
                        return Container();
                      }
                      if (snapshot.hasError) {
                        debugPrint('errror');
                      } else if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            debugPrint('loading create event');
                            return Center(child: spinkitMain);
                          case Status.COMPLETED:
                            debugPrint('complete create event');
                            if ('${snapshot.data!.data}' != 'null') {
                              updateBloc = false;
                              WidgetsBinding.instance!
                                  .addPostFrameCallback((_) {
                                saveEventNameToSharedPreferences(
                                    'EventName', _eventNameController.text);
                                saveEventDateToSharedPreferences(
                                    'EventDate', eventDateString);
                                saveEventTimeToSharedPreferences(
                                    'EventTime', eventTimeString);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserHomePage()),
                                );
                              });
                            } else {
                              updateBloc = true;
                              return Container();
                            }
                            break;
                          case Status.ERROR:
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              updateBloc = true;
                              debugPrint('blah');
                              if (showError) {
                                var snackBar =
                                    const SnackBar(content: Text('error'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                // showToastSNACKBAR(
                                //     json.decode(snapshot.data!.message)['message'], Colors.red);
                              }
                              showError = false;
                            });
                            return Container();
                        }
                      }
                      return Container();
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
