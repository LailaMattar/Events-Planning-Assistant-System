import 'dart:async';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/user.dart';
import 'package:event_planning/models/users.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/box_repo.dart';
import 'package:event_planning/repositories/create_event_repo.dart';
import 'package:event_planning/repositories/login_repo.dart';
import 'package:event_planning/repositories/messages_repo.dart';
import 'package:flutter/cupertino.dart';

class MessagesBloc{
  late MessagesRepo _theRepo;

  late StreamController<ApiResponse<User>> _theController;

  StreamSink<ApiResponse<User>> get theSink => _theController.sink;

  Stream<ApiResponse<User>> get theStream => _theController.stream;

  MessagesBloc(){
    _theController = StreamController<ApiResponse<User>>();
    _theRepo = MessagesRepo();
  }

  getBox(int personId,User user)async{
    debugPrint('get chats bloc');
    theSink.add(ApiResponse.loading('get chats'));
    try {
      final User result = await _theRepo.getMessages(personId,user);
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