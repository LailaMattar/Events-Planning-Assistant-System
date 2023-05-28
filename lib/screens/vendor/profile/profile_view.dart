import 'dart:io';

import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/models/user.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../chat_page.dart';

class ProfileView extends StatefulWidget {
  final VendorProfile vendorProfile;
  final bool isUser;
  const ProfileView({Key? key , required this.vendorProfile,required this.isUser}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState(vendorProfile: vendorProfile,isUser: isUser);
}

class _ProfileViewState extends State<ProfileView> {
  final bool isUser;
  _ProfileViewState({required this.vendorProfile,required this.isUser});
  VendorProfile vendorProfile;
  late String imageLocalUrl = 'http://10.0.2.2:8000';
  late String imageWifiUrl = 'http://192.168.1.152:8000';
  late String imageUrl = imageWifiUrl;
  File? image ;


  @override
  void initState() {
    debugPrint('test image url : '+imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h,),
        Container(
          width: 95.h,
          height: 95.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xffE6E6E6),
            border: Border.all(color: const Color(0xff707070)),
          ),
          child: Stack(
            children: [
              Center(
                child: image!=null?
                ClipOval(
                    child: Image.file(
                      image!,
                      width: 115.h,
                      height: 115.h,
                      fit: BoxFit.fill,
                    )
                ) :
                  vendorProfile.profileThumbnail == ' '
                  ? SvgPicture.asset(
                    'assets/svg/user.svg',
                    semanticsLabel: 'user'
                ):ClipOval(
                  child: Image.network(
                      apiUrl+"storage/UserPhoto/VendorProfile/"+vendorProfile.profileThumbnail,
                      width: 115.h,
                      height: 115.h,
                      fit: BoxFit.fill
                    ),
                ),
              ),
              Visibility(
                visible: false,
                child: Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: InkWell(
                    onTap: ()async{
                      image = await pickImage();
                      setState(() {});
                    },
                    child: Container(
                      width: 35.h,
                      height: 35.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: pink,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        Text(
          vendorProfile.name,
          style: TextStyle(
            fontSize: 18.r,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h,),
        Text(
          vendorProfile.type,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15.r,
          ),
        ),
        SizedBox(height: 10.h,),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/svg/location_pin.svg',
                height: 17.h,
                width: 17.h,
              ),
              SizedBox(width: 10.h,),
              Text(
                vendorProfile.city,
                style: TextStyle(
                  fontSize: 13.r,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 17.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/svg/star.svg',
                height: 17.h,
                width: 17.h,
              ),
              SizedBox(width: 8.h,),
              Text(
                '4.5',
                style: TextStyle(
                  fontSize: 13.r,
                ),
              ),
              SizedBox(width: 10.h,),
              Text(
                '10 reviews',
                style: TextStyle(
                  fontSize: 11.h,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        // Padding(
        //   padding: EdgeInsetsDirectional.only(start: 20.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       SvgPicture.asset(
        //         'assets/svg/user.svg',
        //         semanticsLabel: 'user',
        //         height: 17.h,
        //         width: 17.h,
        //         color: Colors.black,
        //       ),
        //       SizedBox(width: 10.h,),
        //       Text(
        //         '10 members',
        //         style: TextStyle(
        //           fontSize: 13.r,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(height: 10.h,),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/svg/clock.svg',
                semanticsLabel: 'user',
                height: 17.h,
                width: 17.h,
                color: Colors.black,
              ),
              SizedBox(width: 10.h,),
              Text(
                'from (${vendorProfile.since}) to (${vendorProfile.to})',
                style: TextStyle(
                  fontSize: 13.r,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Visibility(
          visible: isUser,
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 20.h),
            child: InkWell(
              onTap: (){
                Navigator.push(
                    context, SlideRightRoute(page: ChatPage(user: User.book(id:selectedId,name:vendorProfile.name,
                    image: vendorProfile.profileThumbnail, type: 'vendor'),)));
              },
              child: Text(
                'Send Message!',
                style: TextStyle(
                  color: pink,
                  fontSize: 15.r,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}