import 'package:event_planning/models/vendor_card.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/screens/event_owner/vendor_listview.dart';
import 'package:event_planning/screens/vendor/profile/vendor_profil_page.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class VendorSearcCard extends StatelessWidget {
  final VendorProfile vendorData;

  VendorSearcCard(this.vendorData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print(vendorData.name);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VendorProfilePage(
                    isHall: false, isUser: true, id: vendorData.id)),
          );
        },
        child: Container(
          height: 146,
          width: 175,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0, //shadow
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: vendorData.profileThumbnail == ' '
                      ? CircleAvatar(
                          backgroundImage: AssetImage('assets/svg/user.svg'),
                          radius: 150,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(apiUrl +
                              "storage/UserPhoto/VendorProfile/" +
                              vendorData.profileThumbnail),
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
                                  Text(
                                    vendorData.name,
                                    style: const TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(children: [
                                    Icon(Icons.location_on_outlined,
                                        size: 20.0, color: Colors.black),
                                    Text("${vendorData.city}",
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ]),
                                  SizedBox(height: 10.0),
                                ]),
                            Expanded(
                              child: Text(
                                vendorData.about,
                                softWrap: false,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis, // new

                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14.0),
                              ),
                            ),
                          ])),
                ),
              ]),
            ),
          ),
        ));
  }
}
