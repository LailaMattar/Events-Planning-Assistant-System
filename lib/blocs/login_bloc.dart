import 'dart:async';

import 'package:event_planning/models/login.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/login_repo.dart';
import 'package:flutter/cupertino.dart';

class LoginBloc{
  late LoginRepo _theRepo;

  late StreamController<ApiResponse<Login>> _theController;

  StreamSink<ApiResponse<Login>> get theSink => _theController.sink;

  Stream<ApiResponse<Login>> get theStream => _theController.stream;

  LoginBloc(){
    _theController = StreamController<ApiResponse<Login>>();
    _theRepo = LoginRepo();
  }

  login(Login login)async{
    debugPrint('login bloc');
    theSink.add(ApiResponse.loading('First Signing'));
    try {
      final Login loginResult = await _theRepo.login(login);
      theSink.add(ApiResponse.completed(loginResult));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  dispose() {
    _theController.close();
  }
}