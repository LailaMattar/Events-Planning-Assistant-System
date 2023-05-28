import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/models/ggguest.dart';
import 'package:event_planning/models/guest.dart';
import 'package:event_planning/screens/event_owner/edit_guest.dart';
import 'package:event_planning/screens/event_owner/guest_list.dart';
import 'package:event_planning/screens/event_owner/reservation_details.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';

import 'alertDialog_widget.dart';

class GuestCard extends StatelessWidget {
  GuestInfo guest;

  GuestCard(this.guest);

  showDialog11(BuildContext context) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context).pop(),
          print('hhhh')

          // code on continue comes here
        };
    BlurryDialog alert = BlurryDialog("Confirmation",
        "Are you sure that you want to delete this guest ?", continueCallBack);

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
          print(guest.name);
        },
        child: Container(
          height: 100,
          width: 175,
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
                          guest.name,
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
                                  Navigator.push(context,
                                      SlideRightRoute(page: EditGuest(guest)));
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
                  Text(guest.phone_number.toString(),
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
