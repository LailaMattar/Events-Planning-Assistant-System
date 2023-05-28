import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_planning/blocs/advBloc.dart';
import 'package:event_planning/blocs/vendorByNameBloc.dart';
import 'package:event_planning/blocs/vendorByNameBloc2.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/components/vendor_category_card.dart';
import 'package:event_planning/models/adv.dart';
import 'package:event_planning/models/advList.dart';
import 'package:event_planning/models/hall_profile.dart';
import 'package:event_planning/models/vendorName.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/e_cards/w1.dart';
import 'package:event_planning/screens/event_owner/enter_promo_code.dart';
import 'package:event_planning/screens/event_owner/guest_list.dart';
import 'package:event_planning/screens/event_owner/vendors_view.dart';
import 'package:event_planning/screens/vendor/profile/vendor_profil_page.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_count_down/date_count_down.dart';

import 'favorite_list.dart';
import 'my_reservations.dart';

class MyEventView extends StatefulWidget {
  const MyEventView({Key? key}) : super(key: key);

  @override
  _MyEventViewState createState() => _MyEventViewState();
}

class _MyEventViewState extends State<MyEventView> {
  //var token = await getFromSharedPreferences('token');
  var eventTime = '30:10:00', eventDate = '2022-09-09', eventName = '';
  late int eventId;

  late AdvBloc _theBloc;
  late Adv adv;

  @override
  void initState() {
    _theBloc = AdvBloc();
  }

  static const List<Choice> choices = <Choice>[
    Choice(
        title: 'My reservation',
        icon: Icons.calendar_today,
        firstColor: Colors.indigoAccent,
        secondColor: Colors.lightBlueAccent),
    Choice(
        title: 'Guests List',
        icon: Icons.people,
        firstColor: Colors.indigoAccent,
        secondColor: Colors.lightBlueAccent),
    Choice(
        title: 'Favorites',
        icon: Icons.favorite_border,
        firstColor: Colors.indigoAccent,
        secondColor: Colors.lightBlueAccent)
  ];
  List<String> images = ["assets/images/ad1.png", "assets/images/ad2.png"];

  // Future<void> getdata() async {
  //   eventTime = await getEventTimeFromSharedPreferences('EventTime');
  //   eventName = await getEventNameFromSharedPreferences('EventName');
  //   eventDate = await getEventDateFromSharedPreferences('EventDate');
  // }

  @override
  Widget build(BuildContext context) {
    // print('tttt $eventDate $eventTime');

    return Scaffold(
        //appBar: AppBar(title: Text("Evento")),
        body: SafeArea(
            child: Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.topCenter,
                fit: StackFit.loose,
                children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xdfffecec),
            child: Column(children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                      padding:const EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/gliter1.jpg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60.0),
                              bottomRight: Radius.circular(60.0)),
                        ),
                      ))),
              Expanded(
                flex: 4,
                child: Column(children: [
                  Expanded(
                    flex: 2,
                    child: StreamBuilder<ApiResponse<AdvList>>(
                        stream: _theBloc.theStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            debugPrint('error');
                          } else if (snapshot.hasData) {
                            switch (snapshot.data!.status) {
                              case Status.LOADING:
                                debugPrint('loading offers');
                                return const LoadingPage();
                              case Status.COMPLETED:
                                debugPrint('complete offers');
                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) async {
                                  eventTime =
                                      await getEventTimeFromSharedPreferences(
                                          'EventTime');
                                  eventName =
                                      await getEventNameFromSharedPreferences(
                                          'EventName');
                                  eventDate =
                                      await getEventDateFromSharedPreferences(
                                          'EventDate');
                                  eventId =
                                      await getEventIdFromSharedPreferencesint(
                                          'EventId');

                                  setState(() {});
                                });
                                return CompletePage(snapshot.data!.data);
                              case Status.ERROR:
                                debugPrint('error offers');
                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {
                                  var snackBar =
                                      const SnackBar(content: Text('Error'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });
                                return ErrorPage(
                                  onRetryPressed: () => _theBloc.getAdvList(),
                                );
                            }
                          }
                          // debugPrint('outside $snapshot');
                          _theBloc.getAdvList();
                          return Container();
                        }),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context, SlideRightRoute(page: Ecard1()));

                              print('gg');
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 5.0,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Invitation Card',
                                            style: TextStyle(
                                                color: pink,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            'Make your invitation card and share it with your guests !',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            )),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 15, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        int eventid =
                                            await getEventIdFromSharedPreferencesint(
                                                'EventId');

                                        print(choices[0].title);
                                        print('eventid ${eventid}');
                                        Navigator.push(
                                            context,
                                            SlideRightRoute(
                                                page: MyReservations(eventid)));
                                      },
                                      child: Container(
                                          // height: 120,
                                          width: 110,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            elevation: 5.0, //shadow
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  color: Colors.white),
                                              child: Center(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(choices[0].icon,
                                                          size: 35,
                                                          color: Colors.grey),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        choices[0].title,
                                                        style: const TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.grey),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        int eventid =
                                            await getEventIdFromSharedPreferencesint(
                                                'EventId');

                                        print(choices[1].title);
                                        Navigator.push(
                                            context,
                                            SlideRightRoute(
                                                page: Guestslist(eventid)));
                                      },
                                      child: Container(
                                          // height: 120,
                                          width: 110,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            elevation: 5.0, //shadow
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  color: Colors.white),
                                              child: Center(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(choices[1].icon,
                                                          size: 35,
                                                          color: Colors.grey),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        choices[1].title,
                                                        style: const TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.grey),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        print(choices[2].title);
                                        Navigator.push(
                                            context,
                                            SlideRightRoute(
                                                page: FavoriteList()));
                                      },
                                      child: Container(
                                          // height: 120,
                                          width: 110,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            elevation: 5.0, //shadow
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  color: Colors.white),
                                              child: Center(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(choices[2].icon,
                                                          size: 35,
                                                          color: Colors.grey),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        choices[2].title,
                                                        style: const TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.grey),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              )))
                    ]),
                  ),
                ]),
              ),
            ]),
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: pink.withOpacity(0.6),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(60.0),
                                bottomRight: Radius.circular(60.0)),
                          ),
                          child: Center(
                            child: Text('$eventName',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          )),
                    )),
                Expanded(flex: 4, child: Column()),
              ])),
          Positioned(
            top: 160.0,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5.0,
                child: Container(
                  //width: MediaQuery.of(context).size.width,
                  //  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Text(
                        //   'Countdown Timer////:',
                        // ),
                        // CountDownText(
                        //   due: DateTime.utc(2023),
                        //   finishedText: "Done",
                        //   showLabel: true,
                        //   longDateName: true,
                        //   longDateName: true,
                        //   style: TextStyle(color: Colors.blue),
                        // // ),
                        // Text(
                        //   'Countdown Timer with custom label:',
                        // // ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
                          child: CountDownText(
                            //  due: DateTime.parse("2022-08-05 01:14:00"),
                            due: DateTime.parse("$eventDate $eventTime"),
                            finishedText: "Done",
                            showLabel: true,
                            longDateName: true,
                            daysTextLong: "      ",
                            hoursTextLong: "      ",
                            minutesTextLong: "      ",
                            secondsTextLong: "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 10, 15),
                          child: Text(
                            'd            h            m           s  ',
                            style:
                                TextStyle(fontSize: 18, color: Colors.blueGrey),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 33,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(
                    Icons.near_me_outlined,
                    color: Colors.white,
                    size: 33,
                  ),
                ]),
          )
        ])));
  }
}

class CompletePage extends StatefulWidget {
  late final AdvList advList;

  CompletePage(this.advList);

  @override
  _CompletePageState createState() => _CompletePageState(this.advList);
}

class _CompletePageState extends State<CompletePage> {
  late final AdvList advList;

  _CompletePageState(this.advList);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Container(
          // height: 320,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 400,
              aspectRatio: 16 / 9,
              viewportFraction: 2,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              //onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
            // items: images.map((i) {
            //   //   items: advList.map((i) {
            //   return Builder(
            //     builder: (BuildContext context) {
            //       return Container(
            //           width: MediaQuery.of(context).size.width,
            //           margin: EdgeInsets.symmetric(horizontal: 5.0),
            //           decoration: BoxDecoration(color: Colors.white),
            //           child: Image(
            //             //   width: 50.0,
            //             //   height: 50.0,
            //             fit: BoxFit.cover,
            //             image: AssetImage(i),
            //             //       image: Image.network(
            //             // apiUrl +
            //             // "storage/UserPhoto/VendorProfile/" +
            //             // advList.v
            //           ));
            //     },
            //   );
            // }).toList(),

            items: advList.adv.map((item) => adCard(item)).toList(),
          )),
    );
  }
}

class adCard extends StatefulWidget {
  Adv adv;

  adCard(this.adv);

  @override
  _adCardState createState() => _adCardState(this.adv);
}

class _adCardState extends State<adCard> {
  Adv adv;

  _adCardState(this.adv);

  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;
  bool updateBloc2 = false;
  bool visibleStream2 = false;
  bool showError2 = false;
  late VendorByNameBloc _bloc;
  late VendorByNameBloc2 _bloc2;

  late VendorProfile v;
  late HallProfile h;
  @override
  void initState() {
    _bloc = VendorByNameBloc();
    _bloc2 = VendorByNameBloc2();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async {
            if (adv.type == 'copun') {
              Navigator.push(
                  context,
                  SlideRightRoute(
                      page: EnterPromoCode(adv.copunCode.toString())));
            } else if (adv.type == 'default') {
              if (adv.vendorName != " ") {
                print('def vendor');

                visibleStream = true;
                updateBloc = true;
                showError = true;
                setState(() {});
                VendorName vendorName =
                    VendorName(hallName: "", vendorName: adv.vendorName);
                v = await _bloc.getVendorByName(vendorName);
              } else {
                print('def hall');

                visibleStream2 = true;
                updateBloc2 = true;
                showError2 = true;
                setState(() {});
                VendorName vendorName =
                    VendorName(hallName: adv.hallName, vendorName: "");
                h = await _bloc2.getVendorByName(vendorName);
              }
            }
          },
          child: Stack(children: [
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.white),
                child: Image(
                    //   width: 50.0,
                    //   height: 50.0,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        '${apiUrl}storage/publicity/${adv.image}'))),
            Visibility(
              visible: visibleStream,
              child: StreamBuilder<ApiResponse<VendorProfile>>(
                stream: _bloc.theStream,
                builder: (context, snapshot) {
                  debugPrint('inside stream builder');
                  // debugPrint('status code: ${snapshot.data!.status}');
                  if (!updateBloc) {
                    return Container();
                  }
                  if (snapshot.hasError) {
                    debugPrint('errror');
                  } else if (snapshot.hasData) {
                    switch (snapshot.data!.status) {
                      case Status.LOADING:
                        debugPrint('loading create event');
                        return Center(child: spinkitMain);
                      case Status.COMPLETED:
                        debugPrint('complete create event');
                        if ('${snapshot.data!.data}' != 'null') {
                          updateBloc = false;
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            v = snapshot.data!.data;
                            print('vvvv  ${v.name}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VendorProfilePage(
                                      isHall: false, isUser: true, id: v.id)),
                            );
                          });
                        } else {
                          updateBloc = true;
                          return Container();
                        }
                        break;
                      case Status.ERROR:
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          updateBloc = true;
                          debugPrint('blah');
                          if (showError) {
                            var snackBar =
                                const SnackBar(content: Text('error'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            // showToastSNACKBAR(
                            //     json.decode(snapshot.data!.message)['message'], Colors.red);
                          }
                          showError = false;
                        });
                        return Container();
                    }
                  }
                  return Container();
                },
              ),
            ),
            Visibility(
              visible: visibleStream2,
              child: StreamBuilder<ApiResponse<HallProfile>>(
                stream: _bloc2.theStream,
                builder: (context, snapshot) {
                  debugPrint('inside stream builder');
                  // debugPrint('status code: ${snapshot.data!.status}');
                  if (!updateBloc2) {
                    return Container();
                  }
                  if (snapshot.hasError) {
                    debugPrint('errror');
                  } else if (snapshot.hasData) {
                    switch (snapshot.data!.status) {
                      case Status.LOADING:
                        debugPrint('loading create event');
                        return Center(child: spinkitMain);
                      case Status.COMPLETED:
                        debugPrint('complete create event');
                        if ('${snapshot.data!.data}' != 'null') {
                          updateBloc2 = false;
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            h = snapshot.data!.data;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VendorProfilePage(
                                      isHall: true, isUser: true, id: h.id)),
                            );
                          });
                        } else {
                          updateBloc2 = true;
                          return Container();
                        }
                        break;
                      case Status.ERROR:
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          updateBloc2 = true;
                          debugPrint('blah');
                          if (showError2) {
                            var snackBar =
                                const SnackBar(content: Text('error'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            // showToastSNACKBAR(
                            //     json.decode(snapshot.data!.message)['message'], Colors.red);
                          }
                          showError2 = false;
                        });
                        return Container();
                    }
                  }
                  return Container();
                },
              ),
            ),
          ]),
        ));
  }
}
