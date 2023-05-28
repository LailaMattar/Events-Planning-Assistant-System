import 'dart:async';

import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/models/save_post.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/CreateBookRepo.dart';
import 'package:event_planning/repositories/savePostRepo.dart';
import 'package:event_planning/repositories/useCouponRepo.dart';
import 'package:flutter/cupertino.dart';

class UseCouponBloc {
  late UseCouponRepo _theRepo;

  late StreamController<ApiResponse<Coupon>> _theController;

  StreamSink<ApiResponse<Coupon>> get theSink => _theController.sink;

  Stream<ApiResponse<Coupon>> get theStream => _theController.stream;

  UseCouponBloc() {
    _theController = StreamController<ApiResponse<Coupon>>();
    _theRepo = UseCouponRepo();
  }

  useCop(Coupon c, int postid) async {
    debugPrint('save post bloc');
    theSink.add(ApiResponse.loading('cCoupon post'));
    try {
      final Coupon result = await _theRepo.useCop(c, postid);
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  disspose() {
    _theController.close();
  }
}
