import 'package:event_planning/blocs/offers_bloc.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/screens/event_owner/my_event_view.dart';
import 'package:event_planning/screens/event_owner/profile_view.dart';
import 'package:event_planning/screens/event_owner/vendors_view.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'offers_view.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage();

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late MyEvent recentEvent;

  _UserHomePageState();

  int _page = 0;
  PageController controller = PageController();

  final screens = [
    MyEventView(),
    VendorsView(),
    OffersView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _page,
        onTap: (index) {
          setState(() {
            _page = index;
            controller.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.celebration_outlined, size: 30.h),
              label: 'My Event',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined, size: 30.h),
              label: 'Vendors',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined, size: 30.h),
              label: 'Offers',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity, size: 30.h),
              label: 'Profile',
              backgroundColor: Colors.blue),
        ],
      ),
      body: PageView(
          controller: controller,
          children: screens,
          onPageChanged: (index) {
            setState(() {
              _page = index;
            });
          }),
    );
  }
}
