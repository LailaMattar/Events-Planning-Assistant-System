import 'package:event_planning/blocs/activePromoBloc.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/promo_can.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/promo_code.dart';
import 'package:flutter/material.dart';

class EnterPromoCode extends StatefulWidget {
  String advPromo;

  EnterPromoCode(this.advPromo);

  @override
  _EnterPromoCodeState createState() => _EnterPromoCodeState(this.advPromo);
}

class _EnterPromoCodeState extends State<EnterPromoCode> {
  String advPromo;

  _EnterPromoCodeState(this.advPromo);

  final fieldText = TextEditingController();
  late PromoCan res;
  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;
  late ActivePromoBloc _bloc;

  @override
  void initState() {
    _bloc = ActivePromoBloc();
    fieldText.text = advPromo;
    if (advPromo == " ") {
      fieldText.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Enter your code")),
        body: SafeArea(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
              child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Promo code',
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
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: BigButton(
                title: 'Activate',
                onTap: () async {
                  visibleStream = true;
                  updateBloc = true;
                  showError = true;
                  setState(() {});
                  String code = fieldText.text.toString();
                  res = await _bloc.ActivePromo(Coupon(code));
                },
                color: Color(0xffEB2E45),
                Textcolor: Colors.white,
              ),
            ),
            Visibility(
              visible: visibleStream,
              child: StreamBuilder<ApiResponse<PromoCan>>(
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
