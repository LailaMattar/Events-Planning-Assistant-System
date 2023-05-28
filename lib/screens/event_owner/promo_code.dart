import 'package:event_planning/blocs/couponBloc.dart';
import 'package:event_planning/components/promo_card.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/vendor_profile_card.dart';
import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/promo.dart';
import 'package:event_planning/models/user.dart';
import 'package:event_planning/models/usercopoun.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/enter_promo_code.dart';
import 'package:event_planning/screens/event_owner/vendor_listview.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../error_page.dart';
import '../loading_page.dart';

class PromoCode extends StatefulWidget {
  const PromoCode({Key? key}) : super(key: key);

  @override
  _PromoCodeState createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  late CouponBloc _theBloc;

  @override
  void initState() {
    _theBloc = CouponBloc();
  }

  @override
  Widget build(BuildContext context) {
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
              color: Color(0xdffffbfb),
              child: Column(children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/gliter1.jpg"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0)),
                          ),
                        ))),
                Expanded(
                  child: Column(),
                  flex: 3,
                )
              ])),
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: pink.withOpacity(0.6),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 0, 30),
                          child: Text("Promo",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      )),
                ),
                Expanded(flex: 3, child: Column()),
              ])),
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Expanded(
                  flex: 1,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 70, 20, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              SlideRightRoute(page: EnterPromoCode(" ")));
                        },
                        child: Text('Enter your code',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: StreamBuilder<ApiResponse<UserCoupon>>(
                      stream: _theBloc.theStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          debugPrint('error');
                        } else if (snapshot.hasData) {
                          switch (snapshot.data!.status) {
                            case Status.LOADING:
                              debugPrint('loading UserCoupon');
                              return const LoadingPage();
                            case Status.COMPLETED:
                              debugPrint('complete UserCoupon');
                              return CompletePage(
                                snapshot.data!.data,
                              );
                            case Status.ERROR:
                              debugPrint('error UserCoupon');
                              WidgetsBinding.instance!
                                  .addPostFrameCallback((_) {
                                var snackBar =
                                    const SnackBar(content: Text('Error'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                              return ErrorPage(
                                onRetryPressed: () => _theBloc.getUserCoupon(),
                              );
                          }
                        }
                        // debugPrint('outside $snapshot');
                        _theBloc.getUserCoupon();
                        return Container();
                      }),
                  flex: 6,
                )
              ]))
        ])));
  }
}

class CompletePage extends StatefulWidget {
  UserCoupon userCoupon;
  CompletePage(this.userCoupon);

  @override
  _CompletePageState createState() => _CompletePageState(this.userCoupon);
}

class _CompletePageState extends State<CompletePage> {
  UserCoupon userCoupon;

  _CompletePageState(this.userCoupon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
            itemBuilder: (BuildContext, index) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
                  child: PromoCard(userCoupon.mycopuns[index]));
            },
            itemCount: userCoupon.mycopuns.length,
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
          )
        ]),
      ),
    );
  }
}
