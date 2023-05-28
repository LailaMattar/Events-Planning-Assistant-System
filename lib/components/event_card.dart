import 'package:event_planning/components/alertDialog_widget.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/screens/event/create_event_page.dart';
import 'package:event_planning/models/favoriteList.dart';
import 'package:event_planning/screens/event_owner/edit_guest.dart';
import 'package:event_planning/screens/event_owner/enter_promo_code.dart';
import 'package:event_planning/screens/event_owner/favorite_list.dart';
import 'package:event_planning/screens/event_owner/guest_list.dart';
import 'package:event_planning/screens/event_owner/home_page.dart';
import 'package:event_planning/screens/event_owner/my_reservations.dart';
import 'package:event_planning/screens/event_owner/profile_view.dart';
import 'package:event_planning/screens/event_owner/report.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  MyEvent event;

  EventCard(this.event);

  showDialog11(BuildContext context) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context).pop(),
          print('hhhh')

          // code on continue comes here
        };
    BlurryDialog alert = BlurryDialog("Confirmation",
        "Are you sure that you want to delete this event ?", continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          saveEventNameToSharedPreferences('EventName', event.name);
          saveEventDateToSharedPreferences('EventDate', event.date);
          saveEventTimeToSharedPreferences('EventTime', event.time);
          saveEventIdToSharedPreferencesint('EventId', event.id);
          // Navigator.push(context, SlideRightRoute(page: MyReservations(16)));
          //  Navigator.push(context, SlideRightRoute(page: Report(24)));
          Navigator.push(context, SlideRightRoute(page: UserHomePage()));
        },
        child: Container(
          height: 100,
          // width: 175,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0, //shadow
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          event.name,
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                              child: IconButton(
                                iconSize: 18.0,
                                icon: Icon(
                                  Icons.edit,
                                  color: pink,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      SlideRightRoute(
                                          page: CreateEventPage(
                                        eventTimeString: event.time,
                                        eventName: event.name,
                                        eventDateString: event.date,
                                      )));
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: IconButton(
                                  iconSize: 18.0,
                                  icon: Icon(
                                    Icons.delete,
                                    color: pink,
                                  ),
                                  onPressed: () {
                                    showDialog11(context);
                                  }),
                            )
                          ],
                        ),
                      ]),
                  SizedBox(height: 5.0),
                  Text('${event.date} - ${event.time}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
