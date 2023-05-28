import 'package:event_planning/blocs/status_book_bloc.dart';
import 'package:event_planning/components/alertDialog_widget.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/my_reservations.dart';
import 'package:event_planning/screens/event_owner/vendor_listview.dart';
import 'package:event_planning/screens/posts/booking.dart';
import 'package:event_planning/screens/vendor/my_orders.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';

class MyResDetallis extends StatefulWidget {
  final Book Data1;
  final VendorProfile vendor1;

  MyResDetallis(this.Data1, this.vendor1);
  @override
  _MyResDetallisState createState() =>
      _MyResDetallisState(this.Data1, this.vendor1);
}

class _MyResDetallisState extends State<MyResDetallis> {
  late final Book Data;
  final VendorProfile vendor;

  _MyResDetallisState(this.Data, this.vendor);

  _showDialog(BuildContext context) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context).pop(),
          print('hhhh')
          // code on continue comes here
        };
    BlurryDialog alert = BlurryDialog(
        "Confirmation",
        "Are you sure that you want to cancel this reservation ?",
        continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Reservation details")),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                        children: [
                          InkWell(
                            child: Icon(Icons.edit, color: pink, size: 25),
                            onTap: () {
                              //   Navigator.push(
                              //       context,
                              //       SlideRightRoute(
                              //           page: BookService(Data, 'edit')));
                            },
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                              onTap: () {
                                _showDialog(context);
                              },
                              child: Icon(Icons.delete, color: pink, size: 25))
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: Row(children: [
                          Text(
                            "Status : ",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${orderStatus[Data.status_of_book]}',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                                child: Text(
                              'Vendor : ',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                            WidgetSpan(
                                child: Text(
                              '${vendor.name}',
                              style: TextStyle(
                                color: pink,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Text(
                                "Event Date : ",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            WidgetSpan(
                              child: Text(Data.event_date,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 2),
                          child: Text(
                            "Notes : ",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(3, 8, 3, 8),
                          child: Text(Data.description,
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ))),
                      const SizedBox(
                        height: 12,
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Text(
                                "Price : ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            WidgetSpan(
                                child: Text(
                              "100,000 SP",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Text(
                                "Coupon : ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            WidgetSpan(
                                child: Text(
                              "8000 SP",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Text(
                                "Total Price : ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            WidgetSpan(
                                child: Text(
                              "92,000 SP",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Make sure to pay a deposit to confirm the reservation within a maximum period of ${vendor.period_of_book} days,"
                        " otherwise the reservation will be canceled .",
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: 50,width: double.infinity,
                      //       color: Colors.orange,
                      //
                      //     ),
                      //     Container(
                      //       height: 50,width: double.infinity,
                      //       color: Colors.redAccent,
                      //
                      //     ),
                      //   ],
                      // ),
                    ])))));
  }
}
