import 'dart:async';

import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/favoriteList.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/models/usercopoun.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/couponRepo.dart';
import 'package:event_planning/repositories/favoriteListRepo.dart';
import 'package:event_planning/repositories/offers_repo.dart';
import 'package:flutter/cupertino.dart';

class CouponBloc {
  late CouponRepo _theRepo;

  late StreamController<ApiResponse<UserCoupon>> _theController;

  StreamSink<ApiResponse<UserCoupon>> get theSink => _theController.sink;

  Stream<ApiResponse<UserCoupon>> get theStream => _theController.stream;

  CouponBloc() {
    _theController = StreamController<ApiResponse<UserCoupon>>();
    _theRepo = CouponRepo();
  }

  getUserCoupon() async {
    print('bloc tstssss');
    theSink.add(ApiResponse.loading('getUserCoupon'));
    try {
      UserCoupon result = await _theRepo.getUserCoupon();
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
}
