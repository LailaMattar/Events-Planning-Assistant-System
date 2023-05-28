import 'package:event_planning/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhoCard extends StatefulWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const WhoCard({Key? key , required this.title, required this.image,required this.onTap})
      : super(key: key);

  @override
  _WhoCardState createState() => _WhoCardState();
}

class _WhoCardState extends State<WhoCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 170.h,
          height: 170.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.h),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding:widget.title == 'Service Provider' ?  EdgeInsets.all(3.h):EdgeInsets.all(0.h),
                    child: Image(
                      width: 110.h,
                      height: 110.h,
                      fit: BoxFit.contain,
                      image: AssetImage(widget.image,),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:  Center(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontFamily: 'Segopr',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.r,
                          color: pink
                      ),
                    ),
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
