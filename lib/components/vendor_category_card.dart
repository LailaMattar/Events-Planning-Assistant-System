import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/screens/event_owner/vendor_listview.dart';
import 'package:event_planning/screens/event_owner/vendors_view.dart';
import 'package:flutter/material.dart';

class VendorCategoryCard extends StatelessWidget {
  final Choice choice;

  VendorCategoryCard({required this.choice});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(choice.title);
        Navigator.push(
            context, SlideRightRoute(page: VendorListView(choice.title)));
      },
      child: Container(
        height: 160,
        width: 175,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5.0, //shadow
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.center,
                  colors: [choice.firstColor, choice.secondColor],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(choice.icon, size: 42.0, color: Colors.white),
                        Text(
                          choice.title,
                          style: const TextStyle(
                              fontSize: 22.0, color: Colors.white),
                        ),
                      ]),
                ),
              ),
            )),
      ),
    );
  }
}
