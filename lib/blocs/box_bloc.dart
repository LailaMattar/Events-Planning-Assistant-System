import 'dart:async';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/user.dart';
import 'package:event_planning/models/users.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/box_repo.dart';
import 'package:event_planning/repositories/create_event_repo.dart';
import 'package:event_planning/repositories/login_repo.dart';
import 'package:flutter/cupertino.dart';

class BoxBloc{
  late BoxRepo _theRepo;

  late StreamController<ApiResponse<Users>> _theController;

  StreamSink<ApiResponse<Users>> get theSink => _theController.sink;

  Stream<ApiResponse<Users>> get theStream => _theController.stream;

  BoxBloc(){
    _theController = StreamController<ApiResponse<Users>>();
    _theRepo = BoxRepo();
  }

  getBox(User user)async{
    debugPrint('get chats bloc');
    theSink.add(ApiResponse.loading('get chats'));
    try {
      final Users result = await _theRepo.getBox(user);
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