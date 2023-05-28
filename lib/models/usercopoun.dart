import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/post.dart';
import 'package:flutter/cupertino.dart';

class UserCoupon {
  late List<Coupon> mycopuns;

  UserCoupon.fromJson(Map<String, dynamic> json) {
    debugPrint('test UserCoupon from json');
    if (json['mycopuns '].length == 0) {
      debugPrint('mycopuns  null');
      mycopuns = [];
    } else {
      debugPrint('mycopuns  length: ${json['mycopuns '].length}');
      debugPrint('mycopuns  not null');
      mycopuns = List<Coupon>.from(
          json['mycopuns '].map((model) => Coupon.fromJson(model)));
    }
  }
}
