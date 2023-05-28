import 'dart:async';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/create_event_repo.dart';
import 'package:event_planning/repositories/login_repo.dart';
import 'package:flutter/cupertino.dart';

class CreateEventBloc{
  late CreateEventRepo _theRepo;

  late StreamController<ApiResponse<MyEvent>> _theController;

  StreamSink<ApiResponse<MyEvent>> get theSink => _theController.sink;

  Stream<ApiResponse<MyEvent>> get theStream => _theController.stream;

  CreateEventBloc(){
    _theController = StreamController<ApiResponse<MyEvent>>();
    _theRepo = CreateEventRepo();
  }

  createEvent(MyEvent event)async{
    debugPrint('create event bloc');
    theSink.add(ApiResponse.loading('Create Event'));
    try {
      final MyEvent result = await _theRepo.createEvent(event);
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