import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/screens/event_owner/myResDetallis.dart';
import 'package:event_planning/screens/event_owner/my_reservations.dart';
import 'package:event_planning/screens/event_owner/reservation_details.dart';
import 'package:event_planning/screens/event_owner/vendor_listview.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyResCard extends StatelessWidget {
  final Book Data;
  final VendorProfile vendor;

  MyResCard(this.Data, this.vendor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print(Data.fullname);
          Navigator.push(
              context, SlideRightRoute(page: MyResDetallis(Data, vendor)));
        },
        child: Container(
            height: 110,
            width: double.infinity,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5.0, //shadow
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: vendor.profileThumbnail == ' '
                          ? CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/svg/user.svg'),
                              radius: 150,
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(apiUrl +
                                  "storage/UserPhoto/VendorProfile/" +
                                  vendor.profileThumbnail),
                              radius: 150,
                            ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Icon(choice.icon, size: 42.0, color: Colors.white),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            vendor.name,
                                            style: const TextStyle(
                                                fontSize: 17.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${orderStatus[Data.status_of_book]}',
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                    SizedBox(height: 12.0),

                                    Text(Data.event_date,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.blueGrey,
                                        )),
                                  ]),
                            ]),
                      ),
                    ),
                  ]),
                ))));
  }
}
