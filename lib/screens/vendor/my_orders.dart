import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/repositories/log_out_repo.dart';
import 'package:event_planning/screens/event_owner/favorite_list.dart';
import 'package:event_planning/screens/startup/login_page.dart';
import 'package:event_planning/screens/vendor/all_view.dart';
import 'package:event_planning/screens/vendor/profile/vendor_profil_page.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyOrders extends StatefulWidget {
  final bool isHall;
  const MyOrders({Key? key,required this.isHall}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState(isHall: isHall);
}

class _MyOrdersState extends State<MyOrders> {
  final bool isHall;
  _MyOrdersState({required this.isHall});
  final fieldText = TextEditingController();
  bool send = false;
  void clearText() {
    fieldText.clear();
  }

  void initState() {
    //hide status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
  }

  List<String> vendors = ['mays', 'll', 'feras', 'tt', 'kok'];

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
                  'Profile',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                  debugPrint("stateeeee : ");
                  if(state == 9){
                    Navigator.push(
                        context, SlideRightRoute(page: VendorProfilePage(isHall: false,isUser: false, id: 0,)));
                  }
                  if(state == 10){
                    Navigator.push(
                        context, SlideRightRoute(page: VendorProfilePage(isHall: true,isUser: false, id: 0,)));
                  }

                  // Navigator.push(
                  //     context, VendorProfilePage(isHall: false,isUser: false, id: 0,));
                },
              ),
              ListTile(
                title: Text(
                  'Settings',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: InkWell(
                  onTap: ()async{
                    LogOutRepo logOutRepo = LogOutRepo();
                    if(isHall){
                      logOutRepo.logOutHall();
                    }else{
                      logOutRepo.logOutVendor();
                    }
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        LoginPage()), (Route<dynamic> route) => false);
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
          // title: Container(
          //     width: double.infinity,
          //     height: 40,
          //     decoration: BoxDecoration(
          //         color: Colors.white54.withOpacity(0.4),
          //         borderRadius: BorderRadius.circular(50)),
          //     child: Center(
          //         child: TextField(
          //       textInputAction: TextInputAction.send,
          //       onSubmitted: (value) {
          //         setState(() {
          //           send = true;
          //         });
          //         print(value);
          //         print("searcccch");
          //       },
          //       controller: fieldText,
          //       decoration: InputDecoration(
          //           prefixIcon: Icon(
          //             Icons.search,
          //             color: Colors.white,
          //           ),
          //           suffixIcon: IconButton(
          //             icon: Icon(Icons.clear, color: Colors.white),
          //             onPressed: () {
          //               clearText();
          //               setState(() {
          //                 send = false;
          //               });
          //             },
          //           ),
          //           hintText: 'Search',
          //           border: InputBorder.none),
          //     ))),
          title: Text("My reservations"),
        ),
        body: MaterialApp(
          home: DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Container(
                    height: 50.0,
                    child: TabBar(
                      tabs: [
                        Tab(text: 'All'),
                        Tab(text: 'Pending'),
                        Tab(text: 'Accepted'),
                        Tab(text: 'In progress'),
                        Tab(text: 'Delivered'),
                      ],
                      indicatorColor: pink,
                      unselectedLabelColor: Colors.blueGrey,
                      labelColor: pink,
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    OrderView('all'),
                    OrderView('pending'),
                    OrderView('accepted'),
                    OrderView('inprogress'),
                    OrderView('delivered'),
                  ],
                ),
              )),
        ));
  }
}
//بدي يرجعلي ال ا ب اي اخر كم شغلة بحثن عنن اليوزر واقدر امحين
///
