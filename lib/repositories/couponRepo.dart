import 'package:event_planning/models/favoriteList.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/models/usercopoun.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class CouponRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<UserCoupon> getUserCoupon() async {
    print('hi');
    final response = await _helper.get('api/user/usercopuns');
    debugPrint('the  UserCoupon body is $response');
    return UserCoupon.fromJson(response);
  }
}
