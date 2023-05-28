import 'dart:convert';

import 'package:event_planning/models/user.dart';
import 'package:event_planning/models/users.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class BoxRepo{
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Users> getBox(User user) async {
    debugPrint('get chats repo');
    final response = await _helper.post('api/box', jsonEncode(user.toJsonBox()));
    return Users.fromJson(response);
  }
}