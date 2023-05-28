import 'dart:convert';

import 'package:event_planning/models/login.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/cupertino.dart';

class LoginRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Login> login(Login login) async {
    debugPrint('login repo');
    final response = await _helper.post('api/user/login', jsonEncode(login));
    debugPrint('the body is $response');
    String token = response['token'];
    token = 'Bearer ' + token;
    debugPrint('token is $token');
    saveToSharedPreferences('token', token);
    saveUserIdToSharedPreferencesint('UserId', response['id']);
    myId = response['id'];
    saveUserNameToSharedPreferences('UserName', response['name']);
    return Login.fromJson(response);
  }
}
