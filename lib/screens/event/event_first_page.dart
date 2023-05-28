import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/screens/event_owner/home_page.dart';
import 'package:event_planning/screens/event_owner/select_event.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'create_event_page.dart';

class EventFirstPage extends StatefulWidget {
  final bool isRegister;

  const EventFirstPage({Key? key, required this.isRegister}) : super(key: key);

  @override
  _EventFirstPageState createState() =>
      _EventFirstPageState(isRegister: this.isRegister);
}

class _EventFirstPageState extends State<EventFirstPage> {
  final bool isRegister;

  _EventFirstPageState({required this.isRegister});

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
                  height: 100.h,
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
                  height: 20.h,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 30.h),
                    child: Text(
                      '  Planning your event',
                      style: TextStyle(
                        color: const Color(0xff787878),
                        fontSize: 20.r,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.h),
                    child: BigButton(
                        title: 'Create new event',
                        Textcolor: Colors.white,
                        color: pink,
                        onTap: () {
                          Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: const CreateEventPage(
                                eventDateString: " ",
                                eventName: " ",
                                eventTimeString: " ",
                              )));
                        })),
                SizedBox(
                  height: 10.h,
                ),
                Visibility(
                  visible: !isRegister,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0.h),
                      child: BigButton(
                          title: 'Select event',
                          Textcolor: Colors.white,
                          color: Colors.grey,
                          onTap: () {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SelectEvent()),
                              );
                            });
                          })),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(25, 30, 45, 0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'Skip',
                //         style: TextStyle(
                //             color: pink,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 16),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
