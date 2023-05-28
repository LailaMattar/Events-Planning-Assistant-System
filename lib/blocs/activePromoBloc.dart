import 'dart:async';

import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/promo_can.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/activePromoRepo.dart';
import 'package:event_planning/repositories/create_event_repo.dart';
import 'package:event_planning/repositories/login_repo.dart';
import 'package:flutter/cupertino.dart';

class ActivePromoBloc {
  late ActivePromoRepo _theRepo;

  late StreamController<ApiResponse<PromoCan>> _theController;

  StreamSink<ApiResponse<PromoCan>> get theSink => _theController.sink;

  Stream<ApiResponse<PromoCan>> get theStream => _theController.stream;

  ActivePromoBloc() {
    _theController = StreamController<ApiResponse<PromoCan>>();
    _theRepo = ActivePromoRepo();
  }

  ActivePromo(Coupon coupon) async {
    debugPrint('ActivePromoBloc bloc');
    theSink.add(ApiResponse.loading('ActivePromoBloc'));
    try {
      final PromoCan result = await _theRepo.ActivePromo(coupon);
      theSink.add(ApiResponse.completed(result));
      return result;
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  dispose() {
    _theController.close();
  }
}
