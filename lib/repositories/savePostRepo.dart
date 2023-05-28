import 'dart:convert';

import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/models/save_post.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';

class SavePostRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<SavePost> savePost(SavePost post) async {
    debugPrint('save post repo');

    final response =
        await _helper.post('api/favoritepost', jsonEncode(post.toJson()));
    debugPrint('save post response ${response.toString()}');
    return SavePost.fromJsonType();
  }
}
