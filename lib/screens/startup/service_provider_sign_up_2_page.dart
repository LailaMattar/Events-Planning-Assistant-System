import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/models/signup_hall.dart';
import 'package:event_planning/screens/startup/service_provider_sign_up_1_page.dart';
import 'package:event_planning/screens/startup/sign_up_page_2.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late SignUpHall hall;

class ServiceProviderSignUpPage2 extends StatefulWidget {
  final int type;
  const ServiceProviderSignUpPage2({Key? key,required this.type}) : super(key: key);

  @override
  _ServiceProviderSignUpPage2State createState() => _ServiceProviderSignUpPage2State(type: type);
}

class _ServiceProviderSignUpPage2State extends State<ServiceProviderSignUpPage2> {
  final int type;
  _ServiceProviderSignUpPage2State({required this.type});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  late bool isHall ;


  @override
  void initState() {
    if(type == 1){
      isHall = true;
    }else{
      isHall = false;
    }
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
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 30.h),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: pink,
                            fontSize: 20.r,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.h),
                    child: Container(
                      height: 250.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffE9EDF2),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: TextFormField(
                        controller: _descriptionController,
                        maxLines: 250,
                        style: TextStyle(
                            fontSize: 15.r
                        ),
                        decoration: InputDecoration(
                          hintText: 'Description of your service',
                          fillColor: const Color(0xffE9EDF2),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.h),
                            borderSide:const BorderSide(color: Colors.transparent),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius : BorderRadius.all(Radius.circular(10.h)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius : BorderRadius.all(Radius.circular(10.h)),
                          ),
                          hintStyle:const TextStyle(
                              color: Color(0xff919191)
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Visibility(
                    visible: isHall,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.h),
                        child: Text(
                          'Number of guests',
                          style: TextStyle(
                            fontSize: 15.r,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Visibility(
                    visible: isHall,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: TextFormField(
                        controller: _minController,
                        style: TextStyle(
                            fontSize: 15.r
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Min',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.h),
                            borderSide:const BorderSide(color: Colors.transparent),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius : BorderRadius.all(Radius.circular(10.h)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius : BorderRadius.all(Radius.circular(10.h)),
                          ),
                          hintStyle:const TextStyle(
                              color: Color(0xff919191)
                          ),
                          filled: true,
                          fillColor: const Color(0xffE9EDF2),
                          contentPadding: EdgeInsets.all(12.h),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Visibility(
                    visible: isHall,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: TextFormField(
                        controller: _maxController,
                        style: TextStyle(
                            fontSize: 15.r
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Max',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.h),
                            borderSide:const BorderSide(color: Colors.transparent),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius : BorderRadius.all(Radius.circular(10.h)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius : BorderRadius.all(Radius.circular(10.h)),
                          ),
                          hintStyle:const TextStyle(
                              color: Color(0xff919191)
                          ),
                          filled: true,
                          fillColor: const Color(0xffE9EDF2),
                          contentPadding: EdgeInsets.all(12.h),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0.h),
                      child: BigButton(title: 'Next',color: pink,onTap: (){
                        if(type == 1){
                          vendor.about = _descriptionController.text;
                          hall = SignUpHall(max_number_of_person: _maxController.text,min_number_of_person: _minController.text, vendor: vendor);
                          Navigator.push(
                              context,
                              SlideRightRoute(page: const SecondSignUpPage(isVendor: true,isHall: true))
                          );
                        }
                        else{
                          vendor.about = _descriptionController.text;
                          Navigator.push(
                              context,
                              SlideRightRoute(page: const SecondSignUpPage(isVendor: true,isHall: false))
                          );
                        }
                      },Textcolor:Colors.white)
                  ),
                  SizedBox(height: 20.h,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
