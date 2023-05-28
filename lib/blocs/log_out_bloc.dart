import 'dart:async';

import 'package:event_planning/models/log_out.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/log_out_repo.dart';
import 'package:event_planning/repositories/offers_repo.dart';
import 'package:flutter/cupertino.dart';

class LogOutBloc{
  late LogOutRepo _theRepo;

  late StreamController<ApiResponse<LogOut>> _theController;

  StreamSink<ApiResponse<LogOut>> get theSink => _theController.sink;

  Stream<ApiResponse<LogOut>> get theStream => _theController.stream;

  LogOutBloc(){
    _theController = StreamController<ApiResponse<LogOut>>();
    _theRepo = LogOutRepo();
  }

  logOutUser()async{
    theSink.add(ApiResponse.loading('log out user'));
    try{
      LogOut result = await _theRepo.logOutUser();
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
}