import 'dart:convert';

import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/models/save_post.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';

class UnSavePostRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<SavePost> unsavePost(SavePost post) async {
    debugPrint('unsave post repo');

    final response =
        await _helper.post('api/unsave', jsonEncode(post.toJson()));
    debugPrint('unsave post response ${response.toString()}');
    return SavePost.fromJsonType();
  }
}
