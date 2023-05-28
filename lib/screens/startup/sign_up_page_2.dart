import 'dart:convert';
import 'dart:io';

import 'package:event_planning/blocs/signup_bloc.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/slide_right_route.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/models/signup_hall.dart';
import 'package:event_planning/models/signup_user.dart';
import 'package:event_planning/models/signup_vendor.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event/event_first_page.dart';
import 'package:event_planning/screens/startup/service_provider_sign_up_1_page.dart';
import 'package:event_planning/screens/startup/service_provider_sign_up_2_page.dart';
import 'package:event_planning/screens/startup/sign_up_page.dart';
import 'package:event_planning/screens/vendor/my_orders.dart';
import 'package:event_planning/screens/vendor/profile/vendor_profil_page.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class SecondSignUpPage extends StatefulWidget {
  final bool isVendor;
  final bool isHall;
  const SecondSignUpPage({Key? key, required this.isVendor,required this.isHall}) : super(key: key);

  @override
  _SecondSignUpPageState createState() => _SecondSignUpPageState(isVendor: this.isVendor,isHall: this.isHall);
}

class _SecondSignUpPageState extends State<SecondSignUpPage> {
  final bool isVendor;
  final bool isHall;
  _SecondSignUpPageState({required this.isVendor,required this.isHall});
  File? image;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  int activePage = 0;
  late SignUpBloc _bloc;
  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;

  void selectImages() async {
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState((){});
  }


  @override
  void initState() {
    _bloc = SignUpBloc();
    debugPrint("user name: ${user.name}");
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
                SizedBox(height: 20.h,),
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
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.h),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Text(
                                'Upload profile photo :',
                                style: TextStyle(
                                    fontSize: 15.r,
                                    // fontWeight: FontWeight.bold
                                ),
                              )
                          ),
                          WidgetSpan(
                              child: Text(
                                ' ',
                                style: TextStyle(
                                  color: const Color(0xff787878),
                                  fontSize: 15.r,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                Container(
                  width: 115.h,
                  height: 115.h,
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
                        SvgPicture.asset(
                            'assets/svg/user.svg',
                            semanticsLabel: 'user'
                        ),
                      ),
                      Align(
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
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                Visibility(
                  visible: false,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                                child: Text(
                                  'Upload photo for gallery :',
                                  style: TextStyle(
                                    fontSize: 15.r,
                                    // fontWeight: FontWeight.bold
                                  ),
                                )
                            ),
                            WidgetSpan(
                                child: Text(
                                  ' ',
                                  style: TextStyle(
                                    color: const Color(0xff787878),
                                    fontSize: 15.r,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                Visibility(
                  visible: false,
                  child: Container(
                    width: 275.h,
                    height: 275.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffE6E6E6),
                      borderRadius: BorderRadius.circular(10.h),
                    ),
                    child: Center(
                      child:imageFileList!.length == 0? InkWell(
                        onTap: (){
                          selectImages();
                        },
                        child: SvgPicture.asset(
                            'assets/svg/plus.svg',
                            semanticsLabel: 'user'
                        ),
                      ):
                      PageView.builder(
                        itemCount: imageFileList!.length,
                        onPageChanged: (page) {
                          setState(() {
                            activePage = page;
                          });
                        },
                        itemBuilder: (BuildContext context, int imagePosition){
                          return
                            Container(
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.only(topLeft: Radius.circular(10.h),topRight: Radius.circular(10.h)),
                              //   image: DecorationImage(
                              // image: NetworkImage('${apiUrl}profiles/${post.imagePost}'),
                              // fit: BoxFit.fill
                              //   ),
                              // ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Image.file(File(imageFileList![imagePosition].path),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                    AlignmentDirectional.bottomCenter,
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: indicators(
                                            imageFileList!.length, activePage)),
                                  )
                                ],
                              ));
                          },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.h),
                    child: BigButton(title: 'Sign Up',color: pink, Textcolor:Colors.white,onTap: (){
                      visibleStream = true;
                      updateBloc = true;
                      showError = true;
                      setState(() {});
                      if(isVendor == false && isHall == false){
                        if(image != null){
                          user.profile_thumbnail = image!;
                        }
                        _bloc.signupUser(user);
                      }
                      if(isVendor == true && isHall == false){
                        if(image != null){
                          vendor.user.profile_thumbnail = image!;
                        }
                        _bloc.signupVendor(vendor);
                      }
                      if(isVendor == true && isHall == true){
                        if(image != null){
                          hall.vendor.user.profile_thumbnail = image!;
                        }
                        _bloc.signupHall(hall);
                      }
                    })
                ),
                Visibility(
                  visible: visibleStream,
                  child:isVendor == false ? StreamBuilder<ApiResponse<SignUpUser>>(
                    stream: _bloc.theStreamUser,
                    builder: (context, snapshot){
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
                            debugPrint('loading signup');
                            return Center(child: spinkitMain);
                          case Status.COMPLETED:
                            debugPrint('complete signup');
                            if ('${snapshot.data!.data}' != 'null') {
                              updateBloc = false;
                              if(isVendor == false && isHall == false){
                                WidgetsBinding.instance!.addPostFrameCallback((_){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const EventFirstPage(isRegister: true)
                                    ),
                                  );
                                });
                              }else{

                              }

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
                                String error = json.decode(snapshot.data!.message)['message'];
                                var snackBar = SnackBar(content: Text(error));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  ):isHall == false? StreamBuilder<ApiResponse<SignUpVendor>>(
                    stream: _bloc.theStreamVendor,
                    builder: (context, snapshot){
                      debugPrint('inside stream builder vendor');
                      // debugPrint('status code: ${snapshot.data!.status}');
                      if (!updateBloc) {
                        return Container();
                      }
                      if (snapshot.hasError) {
                        debugPrint('errror');
                      } else if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            debugPrint('loading signup');
                            return Center(child: spinkitMain);
                          case Status.COMPLETED:
                            debugPrint('complete signup');
                            if ('${snapshot.data!.data}' != 'null') {
                              updateBloc = false;

                                WidgetsBinding.instance!.addPostFrameCallback((_){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const MyOrders(isHall:false)
                                        // const VendorProfilePage(isHall: false,isUser:false,id:0)
                                    ),
                                  );
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
                                var snackBar = const SnackBar(content: Text('error'));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  ):StreamBuilder<ApiResponse<SignUpHall>>(
                    stream: _bloc.theStreamHall,
                    builder: (context, snapshot){
                      debugPrint('inside stream builder hall');
                      // debugPrint('status code: ${snapshot.data!.status}');
                      if (!updateBloc) {
                        return Container();
                      }
                      if (snapshot.hasError) {
                        debugPrint('errror');
                      } else if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            debugPrint('loading signup');
                            return Center(child: spinkitMain);
                          case Status.COMPLETED:
                            debugPrint('complete signup');
                            if ('${snapshot.data!.data}' != 'null') {
                              updateBloc = false;

                              WidgetsBinding.instance!.addPostFrameCallback((_){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const VendorProfilePage(isHall: true,isUser:false,id:0)
                                  ),
                                );
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
                                var snackBar = const SnackBar(content: Text('error'));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
