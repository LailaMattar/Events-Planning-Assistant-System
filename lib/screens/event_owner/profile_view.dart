import 'package:event_planning/blocs/EventsBloc.dart';
import 'package:event_planning/blocs/log_out_bloc.dart';
import 'package:event_planning/components/event_card.dart';
import 'package:event_planning/components/guest_card.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/models/all_events.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/my_event.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/log_out_repo.dart';
import 'package:event_planning/screens/chats_page.dart';
import 'package:event_planning/screens/error_page.dart';
import 'package:event_planning/screens/event_owner/favorite_list.dart';
import 'package:event_planning/screens/event_owner/guest_list.dart';
import 'package:event_planning/screens/event_owner/promo_code.dart';
import 'package:event_planning/screens/startup/login_page.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../loading_page.dart';
import 'home_page.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late EventsBloc _theBloc;
  late LogOutBloc _logOutBloc;
  late List<MyEvent> myEvents;
  @override
  void initState() {
    //hide status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    _theBloc = EventsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: pink,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: Text('Evento',
                      style: TextStyle(fontSize: 22, color: Colors.white)),
                ),
              ),
              ListTile(
                title: Text(
                  'Favorite list',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);

                  Navigator.push(
                      context, SlideRightRoute(page: FavoriteList()));
                },
              ),
              ListTile(
                title: Text(
                  'Promo',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);


                  Navigator.push(
    context, SlideRightRoute(page: PromoCode()));
    },

              ),
              ListTile(
                title: InkWell(
                  onTap: (){
                    Navigator.push(context, SlideRightRoute(page:const ChatsPage()));
                  },
                  child: Text(
                    'Chats',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ),
              ListTile(
                title: InkWell(
                  onTap: ()async{
                    LogOutRepo logOutRepo = LogOutRepo();
                    await logOutRepo.logOutUser();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        LoginPage()), (Route<dynamic> route) => false);
                    // Navigator.pop(context);
                  },
                  child: Text(
                    'Log out',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.topCenter,
              fit: StackFit.loose,
              children: <Widget>[
                Container(
                  height: 255,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/gliter1.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60.0),
                        bottomRight: Radius.circular(60.0)),
                  ),
                ),
                Container(
                    height: 255,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: pink.withOpacity(0.6),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60.0),
                          bottomRight: Radius.circular(60.0)),
                    )),
                Column(children: [
                  SizedBox(
                    height: 70,
                  ),
                  Stack(children: [
                    Container(
                      width: 110.h,
                      height: 110.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffE6E6E6),
                        border: Border.all(color: const Color(0xff707070)),
                      ),
                      child: ClipOval(
                        child: SvgPicture.asset('assets/svg/user.svg',
                            semanticsLabel: 'user', width: 70.h, height: 70.h),
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(Icons.add_a_photo, color: Colors.black),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                50,
                              ),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(2, 4),
                                color: Colors.black.withOpacity(
                                  0.3,
                                ),
                                blurRadius: 3,
                              ),
                            ]),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Mays Akhatib',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20)),
                ]),
              ]),
          //FlexibleSpaceBar
          //backgroundColor: Colors.greenAccent[400],
          //SliverAppBar
          StreamBuilder<ApiResponse<AllEvents>>(
              stream: _theBloc.theStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  debugPrint('error');
                } else if (snapshot.hasData) {
                  switch (snapshot.data!.status) {
                    case Status.LOADING:
                      debugPrint('loading my events');
                      return const LoadingPage();
                    case Status.COMPLETED:
                      debugPrint('complete myevents');
                      return CompletePage(
                        snapshot.data!.data,
                      );
                    case Status.ERROR:
                      debugPrint('error MyEvents');
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        var snackBar = const SnackBar(content: Text('Error'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                      return ErrorPage(
                        onRetryPressed: () => _theBloc.getMyEvents(),
                      );
                  }
                }
                // debugPrint('outside $snapshot');
                _theBloc.getMyEvents();
                return Container();
              }),
        ])));
  }
}

class CompletePage extends StatefulWidget {
  AllEvents eventss;

  CompletePage(this.eventss);

  @override
  _CompletePageState createState() => _CompletePageState(this.eventss);
}

class _CompletePageState extends State<CompletePage> {
  late AllEvents events;

  _CompletePageState(this.events);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        children: List<Widget>.generate(events.events.length, (index) {
          return Padding(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
              child: EventCard(events.events[index]));
        }));
  }
}
