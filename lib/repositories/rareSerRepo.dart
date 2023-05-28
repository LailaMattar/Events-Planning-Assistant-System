import 'dart:convert';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/rating.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';

class RateSerRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Rating> rateSer(Rating r) async {
    debugPrint('create event repo');
    final response =
        await _helper.post('api/rating-by-id', jsonEncode(r.toJson()));
    return Rating.fromJsonType();
  }
}
