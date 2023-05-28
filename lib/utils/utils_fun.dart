import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future pickImage() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    debugPrint('image picked successfully');
    return imageTemp;
  } on PlatformException catch (e) {
    debugPrint('Failed to pick image: $e');
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3.h),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}

Future<String> getFromSharedPreferences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.get(key).toString();
  return value;
}

saveToSharedPreferences(String key, String value) async {
  debugPrint('key is $key, value is $value');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String> getEventNameFromSharedPreferences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.get(key).toString();
  return value;
}

saveEventNameToSharedPreferences(String key, String value) async {
  debugPrint('key is $key, value is $value');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String> getEventDateFromSharedPreferences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.get(key).toString();
  return value;
}

saveEventDateToSharedPreferences(String key, String value) async {
  debugPrint('key is $key, value is $value');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String> getEventTimeFromSharedPreferences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.get(key).toString();
  return value;
}

saveEventTimeToSharedPreferences(String key, String value) async {
  debugPrint('key is $key, value is $value');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String> getUserNameFromSharedPreferences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.get(key).toString();
  return value;
}

saveUserNameToSharedPreferences(String key, String value) async {
  debugPrint('key is $key, value is $value');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

saveUserIdToSharedPreferencesint(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<int> getUserIdFromSharedPreferencesint(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getInt(key) ?? 0;
  print('the value is $value');
  return value;
}

saveEventIdToSharedPreferencesint(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<int> getEventIdFromSharedPreferencesint(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getInt(key) ?? 0;
  print('the value is $value');
  return value;
}

StreamTransformer<QuerySnapshot, List<T>> transformer<T>(
        T Function(Map<String, dynamic> json) fromJson) =>
    StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
      handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
        final snaps = data.docs.map((doc) => doc.data()).toList();
        final users = snaps.map((json) => fromJson(json)).toList();

        sink.add(users);
      },
    );

DateTime toDateTime(Timestamp value) {
  // if (value == null) return null;

  return value.toDate();
}

dynamic fromDateTimeToJson(DateTime date) {
  if (date == null) return null;

  return date.toUtc();
}

void selectImages(ImagePicker imagePicker, List<XFile>? imageFileList) async {
  final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
  if (selectedImages!.isNotEmpty) {
    imageFileList!.addAll(selectedImages);
  }
  print("Image List Length:" + imageFileList!.length.toString());
  // setState((){});
}

// void showToastSNACKBAR(String text, Color color) {
//   Fluttertoast.showToast(
//       msg: text,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 2,
//       backgroundColor: color,
//       textColor: Colors.white,
//       fontSize: ScreenUtil().setSp(16));
// }
