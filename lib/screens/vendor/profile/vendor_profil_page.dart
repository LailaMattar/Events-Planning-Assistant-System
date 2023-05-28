import 'dart:io';

import 'package:event_planning/blocs/vendor_profile_bloc.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/vendor/profile/about_view.dart';
import 'package:event_planning/screens/vendor/profile/calender_view.dart';
import 'package:event_planning/screens/vendor/profile/posts_view.dart';
import 'package:event_planning/screens/vendor/profile/profile_view.dart';
import 'package:event_planning/screens/vendor/profile/vendor_hospitality_view.dart';
import 'package:event_planning/screens/vendor/profile/vendor_offers_view.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../chats_page.dart';
import 'gallery_view.dart';

class VendorProfilePage extends StatefulWidget {
  final bool isHall;
  final bool isUser;
  final int id;
  const VendorProfilePage({Key? key,required this.isHall,required this.isUser,required this.id}) : super(key: key);

  @override
  _VendorProfilePageState createState() => _VendorProfilePageState(isHall: isHall,isUser:isUser,id:id);
}

class _VendorProfilePageState extends State<VendorProfilePage> with TickerProviderStateMixin{
  File? image;
  late VendorProfileBloc _theBloc;
  final bool isHall;
  final bool isUser;
  final int id;
  _VendorProfilePageState({required this.isHall,required this.isUser,required this.id});


  @override
  void initState() {
    super.initState();
    _theBloc = VendorProfileBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          iconSize: 25.h,
        ),
        title: const Text(
          'Evento',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          !isUser?InkWell(
            onTap:(){
              debugPrint('edit');
            },
            child: Image(
              width: 25.h,
              height: 25.h,
              image: const AssetImage('assets/icons/write.png'),
            ),
          ):Container(),
          SizedBox(width: 5.h,),
          !isUser?InkWell(
            onTap:(){
              Navigator.push(context, SlideRightRoute(page:const ChatsPage()));
              debugPrint('chat');
            },
            child: Image(
              width: 25.h,
              height: 25.h,
              image: const AssetImage('assets/icons/chat.png'),
            ),
          ):Container(),
          // SizedBox(width: 7.h,),
          // !isUser?InkWell(
          //   onTap:(){
          //     debugPrint('edit');
          //   },
          //   child: SvgPicture.asset(
          //       'assets/svg/bell.svg',
          //       semanticsLabel: 'bell'
          //   ),
          // ):Container(),
          SizedBox(width: 10.h,),
        ],
        shape: Border(
            bottom: BorderSide(
                color: Colors.black,
                width: 1.h
            )
        ),
      ),
      body: StreamBuilder<ApiResponse<VendorProfile>>(
        stream: _theBloc.theStream,
        builder: (context,snapshot){
          debugPrint('inside stream builder');
          if (snapshot.hasError) {
            debugPrint('error');
          }else if(snapshot.hasData){
            switch(snapshot.data!.status){
              case Status.LOADING:
                debugPrint('loading profile');
                return const LoadingPage();
              case Status.COMPLETED:
                debugPrint('complete profile');
                return CompletePage(
                  isUser: isUser,
                  isHall: isHall,
                    vendorProfile: snapshot.data!.data
                );
              case Status.ERROR:
                debugPrint('error profile');
                WidgetsBinding.instance!.addPostFrameCallback((_){
                  var snackBar = const SnackBar(content: Text('Error'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
                if(isUser) return ErrorPage(onRetryPressed: () => _theBloc.getVendorProfileById(id),);
                if(isHall && !isUser) return ErrorPage(onRetryPressed: () => _theBloc.getVendorProfileHall(),);
                return ErrorPage(onRetryPressed: () => _theBloc.getVendorProfile(),);
            }
          }
          // debugPrint('outside $snapshot');
          if(isUser && !isHall){
            selectedId = id;
            _theBloc.getVendorProfileById(id);
          } else if(isHall && !isUser){
            _theBloc.getVendorProfileHall();
          } else if(isHall && isUser){
            _theBloc.getHallProfileById(id);
          }else {
            _theBloc.getVendorProfile();
          }
          return Container();
        },
      ),
    );
  }
}
class MyDelegate extends SliverPersistentHeaderDelegate{
  MyDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: spinkitMain
    );
  }
}

class CompletePage extends StatefulWidget {
  final VendorProfile vendorProfile;
  final bool isHall;
  final bool isUser;
  const CompletePage({Key? key,required this.vendorProfile,required this.isHall,required this.isUser}) : super(key: key);

  @override
  _CompletePageState createState() => _CompletePageState(vendorProfile: vendorProfile, isHall: isHall,isUser:isUser);
}

class _CompletePageState extends State<CompletePage> {
  VendorProfile vendorProfile;
  final bool isHall;
  final bool isUser;
  _CompletePageState({required this.vendorProfile,required this.isHall,required this.isUser});

  List<Widget> hallTabs=const [
    Tab(text: 'Services',),
    Tab(text: 'Offers'),
    Tab(text: 'Hospitality'),
    Tab(text: 'Gallery'),
    Tab(text: 'About'),
    Tab(text: 'Calender'),
  ];

  List<Widget> vendorTabs=const [
    Tab(text: 'Services',),
    Tab(text: 'Offers'),
    Tab(text: 'Gallery'),
    Tab(text: 'About'),
    Tab(text: 'Calender'),
  ];

  late List<Widget> tabs;

  @override
  void initState() {
    if(isHall){
      tabs = hallTabs;
    }else{
      tabs = vendorTabs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: isHall?6:5,
      child: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context,isScrolled){
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              flexibleSpace: ProfileView(vendorProfile: vendorProfile,isUser: isUser),
              collapsedHeight: 300.h,
              expandedHeight: 300.h,
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: MyDelegate(
                  TabBar(
                    isScrollable: true,
                    tabs:tabs,
                    indicatorColor: pink,
                    unselectedLabelColor: Colors.black,
                    labelColor: pink,
                  )
              ),
            )
          ];
        }, body:isHall? TabBarView(
        children: [
          PostsView(vendorProfile: vendorProfile,isHall: true,isUser: isUser),
          VendorOffersView(vendorProfile: vendorProfile,isHall: true,isUser: isUser),
          HospitalityView(vendorProfile: vendorProfile,isHall: true,isUser: isUser),
          GalleryView(vendorProfile: vendorProfile,isUser: isUser),
          AboutView(about: vendorProfile.about,),
          CalenderView(vendorProfile: vendorProfile,),
        ],
      ):
      TabBarView(
        children: [
          PostsView(vendorProfile: vendorProfile,isHall: false,isUser: isUser),
          VendorOffersView(vendorProfile: vendorProfile,isHall: false,isUser: isUser),
          GalleryView(vendorProfile: vendorProfile,isUser: isUser),
          AboutView(about: vendorProfile.about,),
          CalenderView(vendorProfile: vendorProfile,),
        ],
      ),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final VoidCallback onRetryPressed;
  const ErrorPage({Key? key, required this.onRetryPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error please try again',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20.r,
            ),
          ),
          MaterialButton(
            onPressed: onRetryPressed,
            color: pink,
            child: const Text(
              'Retry',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}


