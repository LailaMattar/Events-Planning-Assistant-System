import 'dart:io';

import 'package:event_planning/blocs/type_post_bloc.dart';
import 'package:event_planning/components/big_button.dart';
import 'package:event_planning/components/spinners.dart';
import 'package:event_planning/components/star.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/screens/event_owner/home_page.dart';
import 'package:event_planning/screens/vendor/profile/vendor_profil_page.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TypePostPage extends StatefulWidget {
  final bool isHall;
  final String type;
  const TypePostPage({Key? key,required this.isHall,required this.type}) : super(key: key);

  @override
  _TypePostPageState createState() => _TypePostPageState(isHall:isHall,type: this.type);
}

class _TypePostPageState extends State<TypePostPage> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String typeValue = " ";
  File? image;
  late TypePostBloc _theBloc;
  bool updateBloc = false;
  bool visibleStream = false;
  bool showError = false;

  final String type;
  final bool isHall;
  _TypePostPageState({required this.isHall,required this.type});

  @override
  void initState() {
    if(type == 'service'){
      typeValue = 'normal';
    }
    if(type == 'offer'){
      typeValue = 'offer';
    }
    if(type == 'hospitality'){
      typeValue = 'hospitality';
    }
    _theBloc = TypePostBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('type posst'),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.h),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    color: const Color(0xffE9EDF2),
                  ),
                  child: Visibility(
                    visible: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
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
                  controller: _titleController,
                  style: TextStyle(fontSize: 15.r),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.h),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(10.h)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
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
                child: Container(
                  height: 250.h,
                  decoration: BoxDecoration(
                    color: const Color(0xffE9EDF2),
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 250,
                    style: TextStyle(fontSize: 15.r),
                    decoration: InputDecoration(
                      hintText: 'Description',
                      fillColor: const Color(0xffE9EDF2),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.h),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10.h)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10.h)),
                      ),
                      hintStyle: const TextStyle(color: Color(0xff919191)),
                      filled: true,
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
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  style: TextStyle(fontSize: 15.r),
                  decoration: InputDecoration(
                    hintText: 'Price',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.h),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(10.h)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
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
              Container(
                width: 275.h,
                height: 275.h,
                decoration: BoxDecoration(
                  color: const Color(0xffE6E6E6),
                  borderRadius: BorderRadius.circular(10.h),
                ),
                child: image == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                image = await pickImage();
                                setState(() {});
                              },
                              child: SvgPicture.asset('assets/svg/plus.svg',
                                  semanticsLabel: 'user'),
                            ),
                            const Text(
                              'upload photos',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    : Image.file(
                        image!,
                        width: 275.h,
                        height: 275.h,
                        fit: BoxFit.fill,
                      ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.h),
                child: BigButton(
                  title: 'Post',
                  color: pink,
                  onTap: () {
                    visibleStream = true;
                    updateBloc = true;
                    showError = true;
                    setState(() {});
                    Post post = Post(
                        type,
                        image!,
                        _descriptionController.text,
                        _titleController.text,
                        _priceController.text);
                    if(state == 9){
                      _theBloc.typePost(post);
                    }
                    if(state == 10){
                      _theBloc.typePostHall(post);
                    }
                    showError = true;
                    setState(() {});
                  },
                  Textcolor: Colors.white,
                ),
              ),
              Visibility(
                visible: visibleStream,
                child: StreamBuilder<ApiResponse<Post>>(
                  stream: _theBloc.theStream,
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
                          debugPrint('loading post');
                          return Center(child: spinkitMain);
                        case Status.COMPLETED:
                          debugPrint('complete post');
                          if ('${snapshot.data!.data}' != 'null') {
                            updateBloc = false;
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VendorProfilePage(isHall: isHall,isUser: false,id:0)),
                              );
                            });
                          } else {
                            updateBloc = true;
                            return Container();
                          }
                          break;
                        case Status.ERROR:
                          debugPrint('error post');
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
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
