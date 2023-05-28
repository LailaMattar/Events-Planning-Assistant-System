import 'package:event_planning/blocs/addGuestBloc.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/guest.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/material.dart';

import 'guest_list.dart';

class ManuallyGuest extends StatefulWidget {
  const ManuallyGuest({Key? key}) : super(key: key);

  @override
  _ManuallyGuestState createState() => _ManuallyGuestState();
}

class _ManuallyGuestState extends State<ManuallyGuest> {
  final fieldText = TextEditingController();
  final fieldText2 = TextEditingController();

  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;
  late AddGuestBloc _bloc;

  @override
  void initState() {
    _bloc = AddGuestBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add guest manually'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
            child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                    child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Guest name',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffEB2E45)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffEB2E45)),
                        borderRadius: BorderRadius.circular(8),
                      )),
                  controller: fieldText,
                ))),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
            child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                    child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      hintText: 'phone number',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffEB2E45)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffEB2E45)),
                        borderRadius: BorderRadius.circular(8),
                      )),
                  controller: fieldText2,
                ))),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: BigButton(
              title: 'Add',
              onTap: () async {
                print('Add');
                visibleStream = true;
                updateBloc = true;
                showError = true;
                setState(() {});
                int eventid =
                    await getEventIdFromSharedPreferencesint('EventId');
                print('eventidddd $eventid');
                Guest g = Guest(
                    name: fieldText.text.toString(),
                    phone_number: fieldText2.text.toString());
                _bloc.AddGuest(g, eventid);
              },
              color: Color(0xffEB2E45),
              Textcolor: Colors.white,
            ),
          ),
          Visibility(
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
                      debugPrint('loading create event');
                      return Center(child: spinkitMain);
                    case Status.COMPLETED:
                      debugPrint('complete create event');
                      if ('${snapshot.data!.data}' != 'null') {
                        updateBloc = false;
                        WidgetsBinding.instance!
                            .addPostFrameCallback((_) async {
                          int eventid =
                              await getEventIdFromSharedPreferencesint(
                                  'EventId');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Guestslist(eventid)),
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
                          var snackBar = const SnackBar(content: Text('error'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
          )
        ],
      ),
    );
  }
}
