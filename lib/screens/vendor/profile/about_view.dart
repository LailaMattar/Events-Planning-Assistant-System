import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutView extends StatefulWidget {
  final String about;
  const AboutView({Key? key,required this.about}) : super(key: key);

  @override
  _AboutViewState createState() => _AboutViewState(about: about);
}

class _AboutViewState extends State<AboutView> {
  late String about;

  _AboutViewState({required this.about});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h,vertical: 20.h),
      child: Text(
        about,
        style: TextStyle(
            fontSize: 18.h,
            color: Colors.black
        ),
      ),
    );
  }
}
