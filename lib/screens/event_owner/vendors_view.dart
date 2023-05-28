import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/vendor_category_card.dart';
import 'package:event_planning/screens/event_owner/search.dart';
import 'package:event_planning/screens/event_owner/search.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorsView extends StatelessWidget {
  const VendorsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vendors'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, SlideRightRoute(page: SearchPage()));
              },
            ),
          ],
        ),
        body: SafeArea(
            child:
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                //   children: <Widget>[
                //             ],),

                Padding(
          padding: EdgeInsets.all(10.0),
          child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 2.0,
              children: List.generate(choices.length, (index) {
                return Center(
                  child: VendorCategoryCard(choice: choices[index]),
                );
              })),
        )));
  }
}

class Choice {
  const Choice(
      {required this.title,
      required this.icon,
      required this.firstColor,
      required this.secondColor});
  final String title;
  final IconData icon;
  final Color firstColor;
  final Color secondColor;
}

List<Choice> choices = <Choice>[
  Choice(
      title: vendorTypes[0],
      icon: Icons.cake,
      firstColor: const Color(0xffA54DF2),
      secondColor: const Color(0xffE66BFF)),
  Choice(
      title: vendorTypes[1],
      icon: Icons.room_service_outlined,
      firstColor: const Color(0xff3A7BD5),
      secondColor: const Color(0xff00D2FF)),
  Choice(
      title: vendorTypes[2],
      icon: Icons.local_convenience_store_outlined,
      firstColor: const Color(0xffFC1EA2),
      secondColor: const Color(0xffFF9595)),
  Choice(
      title: vendorTypes[3],
      icon: Icons.camera_alt,
      firstColor: const Color(0xff0CEBEB),
      secondColor: const Color(0xff29FFC6)),
  Choice(
      title: vendorTypes[4],
      icon: Icons.star,
      firstColor: const Color(0xffFFAFBD),
      secondColor: const Color(0xffFFC3A0)),
  Choice(
      title: vendorTypes[5],
      icon: Icons.music_note,
      firstColor: const Color(0xffB48FFF),
      secondColor: const Color(0xffDFCCF1)),
  Choice(
      title: vendorTypes[6],
      icon: Icons.favorite,
      firstColor: const Color(0xffEB2039),
      secondColor: const Color(0xffEF6273)),
  Choice(
      title: vendorTypes[7],
      icon: Icons.card_membership_outlined,
      firstColor: const Color(0xffF69334),
      secondColor: const Color(0xffFFD056)),
  Choice(
      title: vendorTypes[8],
      icon: Icons.ac_unit_outlined,
      firstColor: const Color(0xffA54DF2),
      secondColor: const Color(0xffE66BFF)),
  Choice(
      title: vendorTypes[9],
      icon: Icons.pregnant_woman_outlined,
      firstColor: const Color(0xff3A7BD5),
      secondColor: const Color(0xff00D2FF)),
  Choice(
      title: vendorTypes[10],
      icon: Icons.card_giftcard,
      firstColor: const Color(0xffFC1EA2),
      secondColor: const Color(0xffFF9595)),
  Choice(
      title: vendorTypes[11],
      icon: Icons.car_rental,
      firstColor: const Color(0xff0CEBEB),
      secondColor: const Color(0xff29FFC6)),
  Choice(
      title: vendorTypes[12],
      icon: Icons.people,
      firstColor: const Color(0xffFFAFBD),
      secondColor: const Color(0xffFFC3A0)),
];
