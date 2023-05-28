import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/models/signup_vendor.dart';
import 'package:event_planning/screens/startup/service_provider_sign_up_2_page.dart';
import 'package:event_planning/screens/startup/sign_up_page.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late SignUpVendor vendor;

class ServiceProviderSignUp extends StatefulWidget {
  const ServiceProviderSignUp({Key? key}) : super(key: key);

  @override
  _ServiceProviderSignUpState createState() => _ServiceProviderSignUpState();
}

class _ServiceProviderSignUpState extends State<ServiceProviderSignUp> {
  late String typeDropDownValue = " ";
  late String locationDropDownValue = " ";
  late int confirmDropDownValue = 0;
  String fromTimeString = 'From';
  String toTimeString = 'To';
  TimeOfDay? fromTime,toTime;
  final TextEditingController _phoneNumberController =
  TextEditingController();


  @override
  void initState() {
    typeDropDownValue = types.first;
    locationDropDownValue = locations.first;
    // confirmDropDownValue = confirmTimeList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  child: TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 15.r),
                    decoration: InputDecoration(
                      hintText: 'Phone number',
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
                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.h),
                      color:const Color(0xffE9EDF2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          style: TextStyle(
                            fontSize: 15.r,
                            color:const Color(0xff919191),
                          ),
                          value: typeDropDownValue,
                          items: types.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              typeDropDownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.h),
                      color:const Color(0xffE9EDF2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          style: TextStyle(
                            fontSize: 15.r,
                            color:const Color(0xff919191),
                          ),
                          value: locationDropDownValue,
                          items: locations.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              locationDropDownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.h),
                      color:const Color(0xffE9EDF2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          isExpanded: true,
                          style: TextStyle(
                            fontSize: 15.r,
                            color:const Color(0xff919191),
                          ),
                          value: confirmDropDownValue,
                          items: confirmTimeList.map((key, items) {
                            return MapEntry(key,
                               DropdownMenuItem<int>(
                                value: items,
                                child: Text(key),
                              ),
                            );
                          })
                              .values
                              .toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              confirmDropDownValue = newValue!;
                              debugPrint("new value:"+confirmDropDownValue.toString());
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.h),
                    child: Text(
                      'Availability time',
                      style: TextStyle(
                        fontSize: 15.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: InkWell(
                    onTap: ()async{
                      debugPrint('from');
                      TimeOfDay? newTime = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 12, minute: 00));
                      if(newTime != null){
                        fromTime = newTime;
                        if(fromTime!.hour < 10){
                          fromTimeString = '0${fromTime!.hour}:';
                        }else{
                          fromTimeString = '${fromTime!.hour}:';
                        }
                        if(fromTime!.minute < 10){
                          fromTimeString += '0${fromTime!.minute}';
                        }else{
                          fromTimeString += '${fromTime!.minute}';
                        }
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xffE9EDF2),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Text(
                        fromTimeString,
                        style: TextStyle(
                            fontSize: 15.r,
                            color: const Color(0xff919191)
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: InkWell(
                    onTap: ()async{
                      debugPrint('to');
                      TimeOfDay? newTime = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 12, minute: 00));
                      if(newTime != null){
                        toTime = newTime;
                        if(toTime!.hour < 10){
                          toTimeString = '0${toTime!.hour}:';
                        }else{
                          toTimeString = '${toTime!.hour}:';
                        }
                        if(toTime!.minute < 10){
                          toTimeString += '0${toTime!.minute}';
                        }else{
                          toTimeString += '${toTime!.minute}';
                        }
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xffE9EDF2),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Text(
                        toTimeString,
                        style: TextStyle(
                            fontSize: 15.r,
                            color: const Color(0xff919191)
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.h),
                    child: BigButton(title: 'Next',color
                        : pink,onTap: (){
                      if(typeDropDownValue == 'Venues'){
                        vendor = SignUpVendor(since: fromTimeString, period_of_book: confirmDropDownValue.toString(), city: locationDropDownValue,
                            phone_number: _phoneNumberController.text, type: typeDropDownValue, to: toTimeString,
                            user: user);
                        Navigator.push(
                            context,
                            SlideRightRoute(page: const ServiceProviderSignUpPage2(type: 1,))
                        );
                      }else{
                        vendor = SignUpVendor(since: fromTimeString, period_of_book: confirmDropDownValue.toString(), city: locationDropDownValue,
                            phone_number: _phoneNumberController.text, type: typeDropDownValue, to: toTimeString,
                        user: user);
                        Navigator.push(
                            context,
                            SlideRightRoute(page: const ServiceProviderSignUpPage2(type: 2,))
                        );
                      }
                    }, Textcolor:Colors.white)
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
