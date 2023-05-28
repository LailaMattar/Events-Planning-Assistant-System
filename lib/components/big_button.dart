import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigButton extends StatefulWidget {
  final Color color;
  final Color Textcolor;
  final String title;
  final VoidCallback onTap;

  const BigButton(
      {Key? key,
      required this.title,
      required this.color,
      required this.onTap,
      required this.Textcolor})
      : super(key: key);

  @override
  _BigButtonState createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          primary: widget.color,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.5, color: widget.color),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          // minimumSize: Size.fromWidth(double.infinity),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: Text(widget.title,
              style: TextStyle(
                  color: widget.Textcolor,
                  fontSize: 15.r,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
