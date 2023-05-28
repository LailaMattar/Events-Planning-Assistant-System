import 'dart:convert';

import 'package:event_planning/blocs/login_bloc.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/main.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/user.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event/event_first_page.dart';
import 'package:event_planning/screens/event_owner/home_page.dart';
import 'package:event_planning/screens/event_owner/select_event.dart';
import 'package:event_planning/screens/posts/post_details.dart';
import 'package:event_planning/screens/startup/who_are_you_page.dart';
import 'package:event_planning/screens/vendor/my_orders.dart';
import 'package:event_planning/screens/vendor/profile/vendor_profil_page.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginBloc _loginBloc;
  late Login login;
  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
    // _emailController.text = 'leen3@gmail.com';
    // _passwordController.text = '12312312334';
    // _emailController.text = 'EletBlaza22@gmail.com';
    // _passwordController.text = '11122233344';
    FirebaseMessaging.instance.getToken().then((value) {
      String? fcm = value;
      theFcm = fcm.toString();
      debugPrint("test fcm");
      debugPrint('fcmtoken for sign in : ' + fcm.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 250.h,
                          height: 250.h,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/login.jpg',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 30.h),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Text(
                                'Login',
                                style: TextStyle(
                                    color: pink,
                                    fontSize: 20.r,
                                    fontWeight: FontWeight.bold),
                              )),
                              WidgetSpan(
                                  child: Text(
                                ' to your account',
                                style: TextStyle(
                                  color: const Color(0xff787878),
                                  fontSize: 20.r,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 15.r),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.h),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.h)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.h)),
                          ),
                          hintStyle: const TextStyle(color: Color(0xff919191)),
                          filled: true,
                          fillColor: const Color(0xffE9EDF2),
                          contentPadding: EdgeInsets.all(12.h),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(fontSize: 15.r),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.h),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.h)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.h)),
                          ),
                          hintStyle: const TextStyle(color: Color(0xff919191)),
                          filled: true,
                          fillColor: const Color(0xffE9EDF2),
                          contentPadding: EdgeInsets.all(12.h),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 30.h),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          'forgot password?',
                          style: TextStyle(color: pink),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0.h),
                        child: BigButton(
                            title: 'Login',
                            Textcolor: Colors.white,
                            color: pink,
                            onTap: () {
                              visibleStream = true;
                              updateBloc = true;
                              showError = true;
                              setState(() {});
                              login = Login(
                                fcm: theFcm,
                                  email: _emailController.text,
                                  password: _passwordController.text);
                              _loginBloc.login(login);
                              showError = true;
                              setState(() {});
                            })),
                    Visibility(
                      visible: visibleStream,
                      child: StreamBuilder<ApiResponse<Login>>(
                        stream: _loginBloc.theStream,
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
                                  updateBloc = false;
                                  debugPrint("type jahsh : "+snapshot.data!.data.type);
                                  if (snapshot.data!.data.type == 'null') {
                                    debugPrint('type null1');
                                    WidgetsBinding.instance!
                                        .addPostFrameCallback((_) {
                                      state = 8;
                                      // user = User.box()
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EventFirstPage(
                                                    isRegister: false)),
                                      );
                                    });
                                  }  if (snapshot.data!.data.max_number_of_person != 0 && snapshot.data!.data.type == 'null') {
                                    debugPrint('type null2');
                                    WidgetsBinding.instance!
                                        .addPostFrameCallback((_) {
                                          state = 10;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const MyOrders(isHall: true)
                                                // const VendorProfilePage(isHall: true,isUser:false,id:0)),
                                      ));
                                    });
                                  } if(snapshot.data!.data.max_number_of_person == 0 && snapshot.data!.data.type != 'null') {
                                    debugPrint('type null3');
                                    WidgetsBinding.instance!
                                        .addPostFrameCallback((_) {
                                      state = 9;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyOrders(isHall: false)
                                            // const VendorProfilePage(isHall: false,isUser:false,id:0)),
                                      ));
                                    });
                                  }
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
                                    String error = snapshot.data!.message;
                                    debugPrint("mooooo : "+error);
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
                    SizedBox(
                      height: 30.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: const Color(0xff787878),
                              fontSize: 14.r,
                            ),
                          )),
                          WidgetSpan(
                              child: InkWell(
                            onTap: () {
                              debugPrint('sign up');
                              // flutterLocalNotificationsPlugin.show(
                              //   0,
                              //   "testing",
                              //   "test",
                              //   NotificationDetails(
                              //     android: AndroidNotificationChannel(
                              //       channel.id,
                              //     )
                              //   )
                              // );
                              Navigator.push(context,
                                  SlideRightRoute(page: const WhoAreYouPage()));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: pink,
                                fontSize: 14.r,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
