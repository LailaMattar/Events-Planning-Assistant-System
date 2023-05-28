import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:event_planning/models/gallery.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/models/signup_hall.dart';
import 'package:event_planning/models/signup_user.dart';
import 'package:event_planning/models/signup_vendor.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'api_exceptions.dart';

class ApiBaseHelper{
  Future<dynamic> get(String url) async {
    debugPrint('Api Get, url ${apiUrl + url}');
    var responseJson;
    var token = await getFromSharedPreferences('token');
    try {
      final response = await http.get(Uri.parse(apiUrl + url), headers: {
        'Authorization': token
      }).timeout(const Duration(seconds: 12), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      debugPrint(response.statusCode.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    log('GET RESPONSE: $responseJson');
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    print('Api Post, url ${apiUrl + url} ${jsonEncode(body)}');
    var responseJson;
    var token = await getFromSharedPreferences('token');
    try {
      print('inside try');
      final response = await http
          .post(Uri.parse(apiUrl + url),
          headers: {'Authorization': token,
            "content-type": "application/json"},
          body: body)
          .timeout(const Duration(seconds: 12), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      print('after post');
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url,dynamic body) async {
    debugPrint('Api Put, url $url');
    var responseJson;
    try {
      var token = await getFromSharedPreferences('token');
      final response = await http.put(Uri.parse(apiUrl + url),
        body: body,
        headers: {
          'Authorization': token,
          "content-type": "application/json"
        },);
      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection');
    }
    debugPrint('api put.');
    debugPrint(responseJson.toString());
    return responseJson;
  }

  Future uploadmultipleimage(List<XFile> images,String url) async {
    var token = await getFromSharedPreferences('token');
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl + url));
    debugPrint("mmkkmm length : "+images.length.toString());
    request.headers
        .addAll({'Authorization': token, "content-type": "application/json"});
    List<MultipartFile> newList = [];
    for (int i = 0; i < images.length; i++) {
      debugPrint("1235 : "+images[i].path);
      File imageFile = File(images[i].path);
      var stream =
      File(imageFile.path).readAsBytes().asStream();
      var length = File(imageFile.path).lengthSync();
      var multipartFile =  http.MultipartFile("fileName["+i.toString()+"]",
          stream, length,
          filename: imageFile.path.split("/").last);
      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      var r = await http.Response.fromStream(response);
      debugPrint("toti : "+r.body.toString());
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future uploadmultipleimageHall(List<XFile> images,String url) async {
    var token = await getFromSharedPreferences('token');
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl + url));
    debugPrint("mmkkmm length : "+images.length.toString());
    request.headers
        .addAll({'Authorization': token, "content-type": "application/json"});
    List<MultipartFile> newList = [];
    for (int i = 0; i < images.length; i++) {
      debugPrint("1235 : "+images[i].path);
      File imageFile = File(images[i].path);
      var stream =
      File(imageFile.path).readAsBytes().asStream();
      var length = File(imageFile.path).lengthSync();
      var multipartFile =  http.MultipartFile("fileName["+i.toString()+"]",
          stream, length,
          filename: imageFile.path.split("/").last);
      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      var r = await http.Response.fromStream(response);
      debugPrint("toti : "+r.body.toString());
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future<String> uploadImage(url,Post post)async{
    var token = await getFromSharedPreferences('token');
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl + url));
    debugPrint('the image is ${post.userFile}');
    if ('${post.userFile}' != 'null') {
      request.files.add(http.MultipartFile(
          'imagepost',
          File(post.userFile.path).readAsBytes().asStream(),
          File(post.userFile.path).lengthSync(),
          filename: post.userFile.path.split("/").last));
    }
    request.fields['type'] = post.type;
    request.fields['price'] = post.price2;
    request.fields['description'] = post.description;
    request.fields['title'] = post.title;
    request.headers
        .addAll({'Authorization': token, "content-type": "application/json"});
    var apiResponse;
    try {
      var res = await request.send();
      apiResponse = _returnResponseStream(res);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return apiResponse;
  }

  Future<String> uploadImageUser(url,SignUpUser signUpUser)async{
    state = 8;
    var token = await getFromSharedPreferences('token');
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl + url));
    print('Api Post, url ${apiUrl + url}');
    if ('${signUpUser.profile_thumbnail}' != null) {
      debugPrint("yes");
      debugPrint('sthe image i ${signUpUser.profile_thumbnail}');
      request.files.add(http.MultipartFile(
          'profile_thumbnail',
          File(signUpUser.profile_thumbnail.path).readAsBytes().asStream(),
          File(signUpUser.profile_thumbnail.path).lengthSync(),
          filename: signUpUser.profile_thumbnail.path.split("/").last));
    }
    request.fields['name'] = signUpUser.name;
    request.fields['email'] = signUpUser.email;
    request.fields['password'] = signUpUser.password;
    request.fields['gendre'] = signUpUser.gendre;
    request.fields['fcm'] = theFcm;
    print("fcmmmmm : "+theFcm);
    request.headers
        .addAll({'Authorization': token, "content-type": "application/json"});
    var apiResponse;
    try {
      var res = await request.send();
      apiResponse = _returnResponseStream(res);
      var response = await http.Response.fromStream(res);
      var response2 = json.decode(response.body.toString());
      String token2 = response2['token'];
      token2 = 'Bearer '+token2;
      debugPrint('token signup is $token2');
      saveToSharedPreferences('token', token2);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return apiResponse;
  }

  Future<String> uploadImageVendor(url,SignUpVendor signUpVendor)async{
    state = 9;
    var token = await getFromSharedPreferences('token');
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl + url));
    print('Api Post, url ${apiUrl + url}');
    if ('${signUpVendor.user.profile_thumbnail}' != null) {
      debugPrint("yes");
      debugPrint('the image is ${signUpVendor.user.profile_thumbnail}');
      request.files.add(http.MultipartFile(
          'profile_thumbnail',
          File(signUpVendor.user.profile_thumbnail.path).readAsBytes().asStream(),
          File(signUpVendor.user.profile_thumbnail.path).lengthSync(),
          filename: signUpVendor.user.profile_thumbnail.path.split("/").last));
    }
    request.fields['name'] = signUpVendor.user.name;
    request.fields['email'] = signUpVendor.user.email;
    request.fields['password'] = signUpVendor.user.password;
    request.fields['gendre'] = signUpVendor.user.gendre;
    request.fields['type'] = signUpVendor.type;
    request.fields['about'] = signUpVendor.about;
    request.fields['city'] = signUpVendor.city;
    request.fields['phone_number'] = signUpVendor.phone_number;
    request.fields['period_of_book'] = signUpVendor.period_of_book;
    request.fields['since'] = signUpVendor.since;
    request.fields['to'] = signUpVendor.to;
    request.fields['fcm'] = theFcm;
    debugPrint("fcm vendor : "+theFcm);
    request.headers
        .addAll({'Authorization': token, "content-type": "application/json"});
    var apiResponse;
    try {
      var res = await request.send();
      apiResponse = _returnResponseStream(res);
      var response = await http.Response.fromStream(res);
      var response2 = json.decode(response.body.toString());
      String token2 = response2['token'];
      token2 = 'Bearer '+token2;
      debugPrint('token signup is $token2');
      saveToSharedPreferences('token', token2);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return apiResponse;
  }

  Future<String> uploadImageHall(url,SignUpHall signUpHall)async{
    state = 10;
    var token = await getFromSharedPreferences('token');
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl + url));
    print('Api Post, url ${apiUrl + url}');
    if ('${signUpHall.vendor.user.profile_thumbnail}' != null) {
      debugPrint("yes");
      debugPrint('the image is ${signUpHall.vendor.user.profile_thumbnail}');
      request.files.add(http.MultipartFile(
          'profile_thumbnail',
          File(signUpHall.vendor.user.profile_thumbnail.path).readAsBytes().asStream(),
          File(signUpHall.vendor.user.profile_thumbnail.path).lengthSync(),
          filename: signUpHall.vendor.user.profile_thumbnail.path.split("/").last));
    }
    request.fields['name'] = signUpHall.vendor.user.name;
    request.fields['email'] = signUpHall.vendor.user.email;
    request.fields['password'] = signUpHall.vendor.user.password;
    request.fields['gendre'] = signUpHall.vendor.user.gendre;
    request.fields['type'] = signUpHall.vendor.type;
    request.fields['about'] = signUpHall.vendor.about;
    request.fields['city'] = signUpHall.vendor.city;
    request.fields['phone_number'] = signUpHall.vendor.phone_number;
    request.fields['period_of_book'] = signUpHall.vendor.period_of_book;
    request.fields['since'] = signUpHall.vendor.since;
    request.fields['to'] = signUpHall.vendor.to;
    request.fields['max_number_of_person'] = signUpHall.max_number_of_person;
    request.fields['min_number_of_person'] = signUpHall.min_number_of_person;
    request.fields['fcm'] = theFcm;
    request.headers
        .addAll({'Authorization': token, "content-type": "application/json"});
    var apiResponse;
    try {
      var res = await request.send();
      apiResponse = _returnResponseStream(res);
      var response = await http.Response.fromStream(res);
      var response2 = json.decode(response.body.toString());
      String token2 = response2['token'];
      debugPrint("yes2");
      token2 = 'Bearer '+token2;
      debugPrint('token signup is $token2');
      saveToSharedPreferences('token', token2);
      debugPrint("yes3");
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return apiResponse;
  }

  dynamic _returnResponse(http.Response response) {
    print('a response');
    debugPrint('status code : '+response.statusCode.toString());
    var k;
    if (response.statusCode != 200 && response.statusCode != 201) {
      var x = jsonEncode(response.body.toString());
      var y = response.body.toString();
      var z = jsonEncode(response.body);
      k = jsonDecode(response.body);
      print('x is $x ');
      print('y is $y ');
      print('z is $z ');

      print('k is ${k["message"]} ');
    }
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print('responseJson is $responseJson');
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        print('responseJson is $responseJson');
        return responseJson;
      // case 400:
      //   throw BadRequestException(response.body.toString());
      // case 401:
      // case 403:
      //   throw UnauthorisedException(k['message']);
      // case 404:
      //   throw PageNotFoundException(k['message']);
      // case 409:
      //   throw ConflictException(k['message']);
      // case 422:
      //   throw UnprocessableEntity(k['message']);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
  dynamic _returnResponseStream(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = 'Success';
        print('responseJson is $responseJson');
        return responseJson;
      case 201:
        var responseJson = 'Success';
        print('responseJson is $responseJson');
        return responseJson;
      case 400:
        throw BadRequestException('Error 400');
      // case 401:
      // case 403:
      //   throw UnauthorisedException('Not authorized');
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}