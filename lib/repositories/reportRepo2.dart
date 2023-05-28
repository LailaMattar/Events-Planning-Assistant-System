import 'dart:convert';

import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/promo_can.dart';
import 'package:event_planning/models/rep.dart';
import 'package:event_planning/models/rep2.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';

class ReportRepo2 {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Rep2> report(Rep2 rep) async {
    debugPrint('report vendor repo');
    final response =
        await _helper.post('api/report-user-by-id', jsonEncode(rep.toJson()));
    return Rep2.fromJson(response);
  }
}
