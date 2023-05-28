import 'package:event_planning/blocs/status_book_bloc.dart';
import 'package:event_planning/components/alertDialog_widget.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/book.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/my_reservations.dart';
import 'package:event_planning/screens/event_owner/vendor_listview.dart';
import 'package:event_planning/screens/posts/booking.dart';
import 'package:event_planning/screens/vendor/my_orders.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';

class ReservationDetails extends StatefulWidget {
  final Book Data1;

  ReservationDetails(this.Data1);
  @override
  _ReservationDetailsState createState() =>
      _ReservationDetailsState(this.Data1);
}

class _ReservationDetailsState extends State<ReservationDetails> {
  final Book Data;
  late StatusBookBloc _bloc;
  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;

  @override
  void initState() {
    _bloc = StatusBookBloc();
    debugPrint("book id: " + Data.id.toString());
  }

  _ReservationDetailsState(this.Data);

  _showDialog(BuildContext context) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context).pop(),
          print('hhhh')
          // code on continue comes here
        };
    BlurryDialog alert = BlurryDialog(
        "Confirmation",
        "Are you sure that you want to cancel this reservation ?",
        continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Reservation details")),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                        children: [
                          InkWell(
                            child: Icon(Icons.edit, color: pink, size: 25),
                            onTap: () {
                              //   Navigator.push(
                              //       context,
                              //       SlideRightRoute(
                              //           page: BookService(Data, 'edit')));
                            },
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                              onTap: () {
                                _showDialog(context);
                              },
                              child: Icon(Icons.delete, color: pink, size: 25))
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: Row(children: [
                          Text(
                            "Status : ",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${orderStatus[Data.status_of_book]}',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                      ),
                          SizedBox(height: 12,),
                          RichText(
                            text: TextSpan(
                              children: [
                                const WidgetSpan(
                                    child: Text(
                                      'Event owner : ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                WidgetSpan(
                                    child: Text(
                                      '${Data.fullname}',
                                      style: TextStyle(
                                        color: pink,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                      SizedBox(height: 12,),
                          RichText(
                            text: TextSpan(
                              children: [
                                const WidgetSpan(
                                    child: Text(
                                      "Event Date : ",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),),
                                WidgetSpan(
                                    child: Text(Data.event_date,
                                        style:const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        )),),
                              ],
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 2),
                              child:Text(
                                "Notes : ",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                           Padding(
                              padding:const EdgeInsets.fromLTRB(3, 8, 3, 8),
                              child: Text(Data.description,
                                  style:const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey,
                                  ))),
                          const SizedBox(height: 12,),
                          RichText(
                            text:const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Text(
                                    "Price : ",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),),
                                WidgetSpan(
                                  child: Text(
                                    "100,000 SP",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                  )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12,),
                          RichText(
                            text:const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Text(
                                    "Coupon : ",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),),
                                WidgetSpan(
                                    child: Text(
                                      "8000 SP",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12,),
                          RichText(
                            text:const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Text(
                                    "Total Price : ",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),),
                                WidgetSpan(
                                    child: Text(
                                      "92,000 SP",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                      const SizedBox(height: 12,),
                          const SizedBox(height: 20,),
                          Visibility(
                            visible: Data.status_of_book == 0 || Data.status_of_book == 1 || Data.status_of_book == 3,
                            child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: BigButton(title:Data.status_of_book == 0? "in progress":
                                    Data.status_of_book == 3? "accept":"delivered",
                                        color: pink, Textcolor: Colors.white, onTap: (){
                                      visibleStream = true;
                                      updateBloc = true;
                                      showError = true;
                                      setState(() {});
                                      print("ffffff : $state");
                                      if(Data.status_of_book == 0){
                                        if(state == 9){
                                          _bloc.makeBookInProgress(Data.id);
                                        }
                                        if(state == 10){
                                          _bloc.makeBookHallAccept(Data.id);
                                        }
                                        debugPrint("pending");
                                      }
                                      if(Data.status_of_book == 3){
                                        _bloc.makeBookAccept(Data.id);
                                      }
                                      if(Data.status_of_book == 1){
                                        _bloc.makeBookDelivered(Data.id);
                                      }
                                    })
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: BigButton(title: "reject", color: Colors.grey, Textcolor: Colors.white, onTap: (){
                                      visibleStream = true;
                                      updateBloc = true;
                                      showError = true;
                                      setState(() {});
                                      _bloc.makeBookFail(Data.id);
                                    })
                                  )
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: visibleStream,
                            child: StreamBuilder<ApiResponse<Book>>(
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
                                      debugPrint('loading login');
                                      return Center(child: spinkitMain);
                                    case Status.COMPLETED:
                                      debugPrint('complete login');
                                      if ('${snapshot.data!.data}' != 'null') {
                                        WidgetsBinding.instance!
                                            .addPostFrameCallback((_){
                                          updateBloc = false;
                                          setState(() {

                                          });
                                          // Navigator.pop(context);
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                              const MyOrders(isHall: false)), (Route<dynamic> route) => false);


                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           MyOrders()),
                                      // );
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
                                      var snackBar = const SnackBar(
                                          content: Text('error'));
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
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: 50,width: double.infinity,
                      //       color: Colors.orange,
                      //
                      //     ),
                      //     Container(
                      //       height: 50,width: double.infinity,
                      //       color: Colors.redAccent,
                      //
                      //     ),
                      //   ],
                      // ),
                    ])))));
  }
}
