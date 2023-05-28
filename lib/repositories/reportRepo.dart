import 'dart:convert';

import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/promo_can.dart';
import 'package:event_planning/models/rep.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';

class ReportRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Rep> report(Rep rep) async {
    debugPrint('report vendor repo');
    final response =
        await _helper.post('api/report-by-id', jsonEncode(rep.toJson()));
    return Rep.fromJson(response);
  }
}
