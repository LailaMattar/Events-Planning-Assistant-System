import 'dart:io';

import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';

class SignUpUser{
  late String name;
  late String email;
  late String password;
  late String gendre;
  late File profile_thumbnail;
  late String token;
  late String fcm;

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['gendre'] = gendre;
    data['profile_thumbnail'] = profile_thumbnail;
    data['fcm'] = fcm;
    return data;
  }

  SignUpUser({required this.name ,required this.gendre , required this.password , required this.email,required this.fcm});
  SignUpUser.vendor({required this.name ,required this.password , required this.email,required this.fcm});

  SignUpUser.fromJson(){

    // token = json['token'];
    // String token2 = 'Bearer '+token;
    // debugPrint('token is $token2');
    // saveToSharedPreferences('token', token2);
  }
}