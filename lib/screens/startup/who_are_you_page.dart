import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/who_are_you_card.dart';
import 'package:event_planning/screens/startup/sign_up_page.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhoAreYouPage extends StatefulWidget {
  const WhoAreYouPage({Key? key}) : super(key: key);

  @override
  _WhoAreYouPageState createState() => _WhoAreYouPageState();
}

class _WhoAreYouPageState extends State<WhoAreYouPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                        child:Container(
                          decoration:  const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/who_are_you.png')
                              )
                          ),
                        )
                    ),
                  ],
                ),
                SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 50.h,),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(start:30.h),
                              child: Text(
                                'Who are you?',
                                style: TextStyle(
                                  fontSize: 20.r,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 60.h,),
                          WhoCard(title: 'Event owner',image: 'assets/icons/team.png',
                            onTap: (){
                              debugPrint("event owner");
                              Navigator.push(
                                  context,
                                  SlideRightRoute(page: const FirstSignUp(type: 2,))
                              );
                            },
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          WhoCard(title: 'Service Provider',image: 'assets/icons/customer_service.png',
                            onTap: (){
                              debugPrint("Service Provider");
                              Navigator.push(
                                  context,
                                  SlideRightRoute(page: const FirstSignUp(type: 1,))
                              );
                            },
                          ),
                        ],
                      ),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
