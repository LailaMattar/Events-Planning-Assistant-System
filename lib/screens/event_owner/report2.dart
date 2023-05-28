import 'package:event_planning/blocs/activePromoBloc.dart';
import 'package:event_planning/blocs/reportBloc.dart';
import 'package:event_planning/blocs/reportBloc2.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/promo_can.dart';
import 'package:event_planning/models/rep.dart';
import 'package:event_planning/models/rep2.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/promo_code.dart';
import 'package:flutter/material.dart';

class Report2 extends StatefulWidget {
  int uid;
  Report2(this.uid);

  @override
  _Report2State createState() => _Report2State(this.uid);
}

class _Report2State extends State<Report2> {
  int uid;

  _Report2State(this.uid);

  final fieldText = TextEditingController();
  late PromoCan res;
  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;
  late ReportBloc2 _bloc;

  @override
  void initState() {
    _bloc = ReportBloc2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Report")),
        body: SafeArea(
          child: Column(children: [
            Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 8),
                child: TextField(
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: 'write your reasons please .. ',
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
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: BigButton(
                title: 'Send',
                onTap: () async {
                  visibleStream = true;
                  updateBloc = true;
                  showError = true;
                  setState(() {});
                  String reason = fieldText.text.toString();

                  res = await _bloc.report(Rep2(reason: reason, user_id: uid));
                },
                color: Color(0xffEB2E45),
                Textcolor: Colors.white,
              ),
            ),
            Visibility(
              visible: visibleStream,
              child: StreamBuilder<ApiResponse<Rep2>>(
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
                        debugPrint('loading ActivatePromo');
                        return Center(child: spinkitMain);
                      case Status.COMPLETED:
                        debugPrint('complete ActivatePromo');
                        if ('${snapshot.data!.data}' != 'null') {
                          updateBloc = false;
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            if (res.can == 1) {
                              var snackBar = const SnackBar(
                                  content: Text('Coupon activated'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.of(context).pop();
                            } else if (res.can == 2) {
                              var snackBar = const SnackBar(
                                  content: Text('Coupon expired'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (res.can == 3) {
                              var snackBar = const SnackBar(
                                  content: Text(
                                      'Thers is no Coupon with this name ! try again'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
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
          ]),
        ));
  }
}
