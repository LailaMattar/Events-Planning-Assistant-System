import 'package:event_planning/blocs/addGuestBloc.dart';
import 'package:event_planning/blocs/getGuestBloc.dart';
import 'package:event_planning/components/alertDialog_widget.dart';
import 'package:event_planning/components/guest_card.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/eventguest.dart';
import 'package:event_planning/models/guesllisttt.dart';
import 'package:event_planning/models/guest.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/manually_guest.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

import '../error_page.dart';
import '../loading_page.dart';

class Guestslist extends StatefulWidget {
  late int eventid;

  Guestslist(this.eventid);

  @override
  _GuestslistState createState() => _GuestslistState(this.eventid);
}

class _GuestslistState extends State<Guestslist> {
  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  Contact? _contact;

  _GuestslistState(this.eventid);

  late GetGuestBloc _theBloc;
  late Guestlisttt event;

  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;
  late AddGuestBloc _bloc;
  late int eventid;
  @override
  void initState() {
    _bloc = AddGuestBloc();
    _theBloc = GetGuestBloc();

    // eventid = await getEventIdFromSharedPreferencesint('EventId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guests list '),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                ),
                // context and builder are
                // required properties in this widget
                context: context,
                builder: (BuildContext context) {
                  // we set up a container inside which
                  // we create center column and display text

                  // Returning SizedBox instead of a Container
                  return Container(
                    height: 180,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Add guest',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.0),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(32, 15, 0, 5),
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Add manually',
                                    style: TextStyle(fontSize: 15.0),
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    SlideRightRoute(page: ManuallyGuest()));
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(32, 10, 0, 10),
                            child: InkWell(
                              onTap: () async {
                                Guest gg;
                                visibleStream = true;
                                updateBloc = true;
                                showError = true;
                                setState(() {});

                                int eventid =
                                    await getEventIdFromSharedPreferencesint(
                                        'EventId');
                                print('eventidddd contact $eventid');

                                Contact? contact =
                                    await _contactPicker.selectContact();
                                setState(() {
                                  _contact = contact;
                                  if (_contact != null) {
                                    gg = Guest(
                                        name: _contact!.fullName!,
                                        phone_number:
                                            _contact!.phoneNumbers![0]);

                                    _bloc.AddGuest(gg, eventid);
                                  }
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Import from my contacts',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    height: 2,
                                    child: Visibility(
                                      visible: visibleStream,
                                      child: StreamBuilder<ApiResponse<Guest>>(
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
                                                debugPrint(
                                                    'loading create event');
                                                return Center(
                                                    child: spinkitMain);
                                              case Status.COMPLETED:
                                                debugPrint(
                                                    'complete create event');
                                                if ('${snapshot.data!.data}' !=
                                                    'null') {
                                                  updateBloc = false;
                                                  WidgetsBinding.instance!
                                                      .addPostFrameCallback(
                                                          (_) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Guestslist(
                                                                  eventid)),
                                                    );
                                                  });
                                                } else {
                                                  updateBloc = true;
                                                  return Container();
                                                }
                                                break;
                                              case Status.ERROR:
                                                WidgetsBinding.instance!
                                                    .addPostFrameCallback((_) {
                                                  updateBloc = true;
                                                  debugPrint('blah');
                                                  if (showError) {
                                                    var snackBar =
                                                        const SnackBar(
                                                            content:
                                                                Text('error'));
                                                    ScaffoldMessenger.of(
                                                            context)
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: StreamBuilder<ApiResponse<Guestlisttt>>(
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
                  return CompletePage(
                    snapshot.data!.data,
                  );
                case Status.ERROR:
                  debugPrint('error offers');
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    var snackBar = const SnackBar(content: Text('Error'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                  return ErrorPage(
                    onRetryPressed: () => _theBloc.getGuest(eventid),
                  );
              }
            }
            // debugPrint('outside $snapshot');
            _theBloc.getGuest(eventid);
            return Container();
          }),
    );
  }
}

class CompletePage extends StatefulWidget {
  late Guestlisttt event;

  @override
  _CompletePageState createState() => _CompletePageState(this.event);

  CompletePage(this.event);
}

class _CompletePageState extends State<CompletePage> {
  late Guestlisttt event;

  _CompletePageState(this.event);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext, index) {
        return Padding(
            padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
            child: GuestCard(event.event.guest[index]));
      },
      itemCount: event.event.guest.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(15),
      scrollDirection: Axis.vertical,
    );
  }
}
