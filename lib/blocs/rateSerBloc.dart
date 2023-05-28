import 'dart:async';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/rating.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/create_event_repo.dart';
import 'package:event_planning/repositories/login_repo.dart';
import 'package:event_planning/repositories/rareSerRepo.dart';
import 'package:flutter/cupertino.dart';

class RateSerBloc {
  late RateSerRepo _theRepo;

  late StreamController<ApiResponse<Rating>> _theController;

  StreamSink<ApiResponse<Rating>> get theSink => _theController.sink;

  Stream<ApiResponse<Rating>> get theStream => _theController.stream;

  RateSerBloc() {
    _theController = StreamController<ApiResponse<Rating>>();
    _theRepo = RateSerRepo();
  }

  rateSer(Rating r) async {
    debugPrint('create event bloc');
    theSink.add(ApiResponse.loading('Create Event'));
    try {
      final result = await _theRepo.rateSer(r);
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  dispose() {
    _theController.close();
  }
}
