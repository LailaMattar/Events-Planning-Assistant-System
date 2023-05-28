import 'package:event_planning/blocs/CreateBookBloc.dart';
import 'package:event_planning/blocs/useCouponBloc.dart';
import 'package:event_planning/components/alertDialog_widget.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/home_page.dart';
import 'package:event_planning/screens/event_owner/my_reservations.dart';
import 'package:event_planning/screens/posts/post_details.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../test.dart';

class BookService extends StatefulWidget {
  Post post1;
  Book Data1;
  String from1;
  int copoun1;
  int vendorId;
  late double totalPrice;
  final DateTime dateTime;

  BookService(
      {required this.vendorId,
      required this.post1,
      required this.Data1,
      required this.from1,
      required this.copoun1,
      required this.dateTime,
      required this.totalPrice});

  @override
  _BookServiceState createState() => _BookServiceState(
      post: this.post1,
      Data: this.Data1,
      from: this.from1,
      copoun: copoun1,
      vendorId: vendorId,
      dateTime: dateTime,
      totalPrice: this.totalPrice);
}

class _BookServiceState extends State<BookService> {
  late Book Data;
  late String from;
  late Post post;
  late String cop = '';
  late int copoun;
  late int vendorId;
  late DateTime dateTime;
  late double totalPrice;

  late Coupon newpr;
  _BookServiceState(
      {required this.vendorId,
      required this.post,
      required this.Data,
      required this.from,
      required this.copoun,
      required this.dateTime,
      required this.totalPrice});

  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;
  late CreateBookBloc _bloc;
  late DateTime selectedDate;
  bool send = false;

  bool updateBloc2 = false;
  bool visibleStream2 = false;
  bool showError2 = false;
  late UseCouponBloc _bloc2;

  @override
  void initState() {
    _bloc = CreateBookBloc();
    _bloc2 = UseCouponBloc();
    totalPrice = post.price.toDouble();

    if (dateTime.year == 0) {
      selectedDate = DateTime.parse("${Data.event_date}");
    } else {
      selectedDate = DateTime.parse("${dateTime}");
    }

    fromTimeString =
        "${selectedDate.hour}:${selectedDate.minute}:${selectedDate.second}";
  }

  final fieldText = TextEditingController();

  //String selectedDate;
  late String typeDropDownValue = " ";
  late String locationDropDownValue = " ";
  late String confirmDropDownValue = " ";
  late String fromTimeString;
  String toTimeString = 'To';
  TimeOfDay? fromTime, toTime;

  _showDialog(BuildContext context) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context).pop(),
          print('hhhh')
          // code on continue comes here
        };
    BlurryDialog alert = BlurryDialog("Confirmation",
        "are you sure that you want to book this servic ?", continueCallBack);
    //
    // BlurryDialog alert = BlurryDialog(
    //     "Confirmation",
    //     "I am Mays Al-Khatib,and I want to book your service for graduation photo sessions by :\n date : ${selectedDate.toLocal()}"
    //         "\n time : 09:00 am"
    //         "\n price : 98,000 SP",
    //     continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  //  due: DateTime.parse("2022-08-05 01:14:00"),

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Book")),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                          child: Row(children: [
                            Text(
                              "Event owner : ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${Data.fullname}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            )
                          ]),
                        ),
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(children: [
                                Text(
                                  "Event Date : ",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    )),
                                Text(" - $fromTimeString",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    )),
                              ]),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // _selectDate(context);
                                          Navigator.push(
                                              context,
                                              SlideRightRoute(
                                                  page: TableMultiExample(
                                                vendorId: vendorId,
                                                copoun1: copoun,
                                                from1: from,
                                                post1: post,
                                                Data1: Data,
                                              )));
                                        },
                                        child: const Text(
                                          "Select Date",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Color(0xffEB2E45),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      InkWell(
                                        child: const Text(
                                          "Select Time",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Color(0xffEB2E45),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () async {
                                          debugPrint('from');
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: const TimeOfDay(
                                                      hour: 12, minute: 00));
                                          if (newTime != null) {
                                            fromTime = newTime;
                                            if (fromTime!.hour < 10) {
                                              fromTimeString =
                                                  '0${fromTime!.hour}:';
                                            } else {
                                              fromTimeString =
                                                  '${fromTime!.hour}:';
                                            }
                                            if (fromTime!.minute < 10) {
                                              fromTimeString +=
                                                  '0${fromTime!.minute}';
                                            } else {
                                              fromTimeString +=
                                                  '${fromTime!.minute}';
                                            }
                                            setState(() {
                                              fromTimeString;
                                            });
                                          }
                                        },
                                      )
                                    ]),
                              )
                            ]),
                        const Text(
                          "Notes : ",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(3, 8, 3, 8),
                            child: TextField(
                              maxLines: 10,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Color(0xffEB2E45)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Color(0xffEB2E45)),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                              controller: fieldText,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(3, 0, 3, 12),
                            child: Center(
                                child: TextField(
                              textInputAction: TextInputAction.send,
                              onSubmitted: (value) {
                                setState(() {
                                  send = true;
                                });
                                print(value);
                                print("searcccch");

                                visibleStream2 = true;
                                updateBloc2 = true;
                                showError2 = true;
                                setState(() {});
                                Coupon c = Coupon(fieldText.text.toString());
                                cop = fieldText.text.toString();
                                print('ss: ${c.code_owner}');
                                newpr = _bloc2.useCop(c, post.id);
                                print('newpr ${newpr.postprice}');
                                if (newpr.postprice == 2) {
                                  var snackBar = const SnackBar(
                                      content: Text(
                                          'the code is unactiviated or not match the type'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  totalPrice = newpr.postprice;
                                  setState(() {});
                                }
                              },
                              controller: fieldText,
                            ))),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Price : ",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${post.price} SP",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Coupon name : ",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${cop} ",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ])),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Price : ",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${totalPrice} SP",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                )
                              ]),
                        ),
                        Text(
                          "Make sure to pay a deposit to confirm the reservation within a maximum period of 3 days,"
                          " otherwise the reservation will be canceled .",
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 18, 0, 12),
                          child: BigButton(
                              title: 'Book now',
                              color: pink,
                              onTap: () {
                                visibleStream = true;
                                updateBloc = true;
                                showError = true;
                                _showDialog(context);
                                setState(() {
                                  Book book = Book(
                                      description: fieldText.text,
                                      event_date:
                                          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day} $fromTimeString',
                                      fullname: Data.fullname,
                                      event_id: Data.event_id);
                                  _bloc.createBook(book, post.id);
                                });
                              },
                              Textcolor: Colors.white),
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
                                    debugPrint('loading create book');
                                    return Center(child: spinkitMain);
                                  case Status.COMPLETED:
                                    debugPrint('complete create book');
                                    if ('${snapshot.data!.data}' != 'null') {
                                      updateBloc = false;
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((_) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserHomePage()),
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
                        SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          height: 0.0,
                          child: Visibility(
                            visible: visibleStream2,
                            child: StreamBuilder<ApiResponse<Coupon>>(
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
                                      debugPrint('loading create book');
                                      return Center(child: spinkitMain);
                                    case Status.COMPLETED:
                                      debugPrint('complete create book');
                                      if ('${snapshot.data!.data}' != 'null') {
                                        updateBloc2 = false;
                                        WidgetsBinding.instance!
                                            .addPostFrameCallback((_) {});
                                      } else {
                                        updateBloc2 = true;
                                        return Container();
                                      }
                                      break;
                                    case Status.ERROR:
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((_) {
                                        updateBloc2 = true;
                                        debugPrint('blah');
                                        if (showError2) {
                                          var snackBar = const SnackBar(
                                              content: Text('error'));
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
                        ),
                      ]),
                ))));
  }
}
