import 'dart:convert';

import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/promo_can.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';

class ActivePromoRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<PromoCan> ActivePromo(Coupon coupon) async {
    debugPrint('active promo repo');
    final response =
        await _helper.post('api/user/active', jsonEncode(coupon.PromotoJson()));
    return PromoCan.fromJson(response);
  }
}
