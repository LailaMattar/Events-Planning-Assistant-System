import 'package:event_planning/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorPage extends StatelessWidget {
  final VoidCallback onRetryPressed;
  const ErrorPage({Key? key, required this.onRetryPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error please try again',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20.r,
            ),
          ),
          MaterialButton(
            onPressed: onRetryPressed,
            color: pink,
            child: const Text(
              'Retry',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}
