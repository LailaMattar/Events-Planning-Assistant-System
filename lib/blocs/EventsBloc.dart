import 'dart:async';

import 'package:event_planning/models/all_events.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/EventsRepo.dart';
import 'package:event_planning/repositories/EventsRepo.dart';
import 'package:event_planning/repositories/EventsRepo.dart';
import 'package:flutter/cupertino.dart';

class EventsBloc {
  late EventsRepo _theRepo;

  late StreamController<ApiResponse<AllEvents>> _theController;

  StreamSink<ApiResponse<AllEvents>> get theSink => _theController.sink;

  Stream<ApiResponse<AllEvents>> get theStream => _theController.stream;

  EventsBloc() {
    _theController = StreamController<ApiResponse<AllEvents>>();
    _theRepo = EventsRepo();
  }

  getMyEvents() async {
    theSink.add(ApiResponse.loading('Getting all events'));
    try {
      AllEvents result = await _theRepo.getMyEvents();
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
}
