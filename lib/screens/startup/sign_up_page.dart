import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/models/signup_user.dart';
import 'package:event_planning/screens/startup/service_provider_sign_up_1_page.dart';
import 'package:event_planning/screens/startup/sign_up_page_2.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late SignUpUser user;

class FirstSignUp extends StatefulWidget {
  final int type;
  const FirstSignUp({Key? key,required this.type}) : super(key: key);

  @override
  _FirstSignUpState createState() => _FirstSignUpState(type: this.type);
}

class _FirstSignUpState extends State<FirstSignUp> {
  final int type;
  _FirstSignUpState({required this.type});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late List<String> typeDropDownItems = [];
  late String dropDownValue = " ";

  @override
  void initState() {
    typeDropDownItems = ['Gender', 'Male', 'Female'];
    dropDownValue = 'Gender';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 0.h,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 30.h),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: pink,
                            fontSize: 20.r,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.h),
                    child: TextFormField(
                      controller: _fullNameController,
                      style: TextStyle(fontSize: 15.r),
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.h),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10.h)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10.h)),
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
                          borderRadius: BorderRadius.all(Radius.circular(10.h)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10.h)),
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
                          borderRadius: BorderRadius.all(Radius.circular(10.h)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10.h)),
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
                      controller: _confirmPasswordController,
                      obscureText: true,
                      style: TextStyle(fontSize: 15.r),
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.h),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10.h)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10.h)),
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
                  Visibility(
                    visible: type != 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                          color: const Color(0xffE9EDF2),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.h),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              style: TextStyle(
                                fontSize: 15.r,
                                color: const Color(0xff919191),
                              ),
                              value: dropDownValue,
                              items: typeDropDownItems.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0.h),
                      child: BigButton(
                        title: 'Next',
                        color: pink,
                        onTap: () {
                          if(type == 1){
                            user = SignUpUser(fcm: theFcm,name: _fullNameController.text, gendre: dropDownValue , email: _emailController.text , password: _passwordController.text);
                            Navigator.push(
                                context,
                                SlideRightRoute(
                                    page: const ServiceProviderSignUp()));
                          }else{
                            user = SignUpUser(fcm: theFcm,name: _fullNameController.text, gendre: 'male' , email: _emailController.text , password: _passwordController.text);
                            Navigator.push(
                                context,
                                SlideRightRoute(
                                    page: const SecondSignUpPage(isVendor: false,isHall: false)));
                          }
                        },
                        Textcolor: Colors.white,
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
