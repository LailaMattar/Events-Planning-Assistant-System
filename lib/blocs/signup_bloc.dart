import 'dart:async';

import 'package:event_planning/models/signup_hall.dart';
import 'package:event_planning/models/signup_user.dart';
import 'package:event_planning/models/signup_vendor.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/signup_repo.dart';
import 'package:flutter/cupertino.dart';

class SignUpBloc{
  late SignUpRepo _theRepo;

  late StreamController<ApiResponse<SignUpUser>> _theControllerUser;

  StreamSink<ApiResponse<SignUpUser>> get theSinkUser => _theControllerUser.sink;

  Stream<ApiResponse<SignUpUser>> get theStreamUser => _theControllerUser.stream;

  //vendor
  late StreamController<ApiResponse<SignUpVendor>> _theControllerVendor;

  StreamSink<ApiResponse<SignUpVendor>> get theSinkVendor => _theControllerVendor.sink;

  Stream<ApiResponse<SignUpVendor>> get theStreamVendor => _theControllerVendor.stream;

  //hall
  late StreamController<ApiResponse<SignUpHall>> _theControllerHall;

  StreamSink<ApiResponse<SignUpHall>> get theSinkHall => _theControllerHall.sink;

  Stream<ApiResponse<SignUpHall>> get theStreamHall => _theControllerHall.stream;

  SignUpBloc(){
    _theControllerUser = StreamController<ApiResponse<SignUpUser>>();
    _theControllerVendor = StreamController<ApiResponse<SignUpVendor>>();
    _theControllerHall = StreamController<ApiResponse<SignUpHall>>();
    _theRepo = SignUpRepo();
  }

  signupUser(SignUpUser signUpUser)async{
    debugPrint('signup bloc');
    theSinkUser.add(ApiResponse.loading('First Signing'));
    try {
      final SignUpUser result = await _theRepo.signupUser(signUpUser);
      theSinkUser.add(ApiResponse.completed(result));
    } catch (e) {
      theSinkUser.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  signupVendor(SignUpVendor signUpVendor)async{
    debugPrint('signup vendor bloc');
    theSinkVendor.add(ApiResponse.loading('First Signing'));
    try {
      final SignUpVendor result = await _theRepo.signupVendor(signUpVendor);
      theSinkVendor.add(ApiResponse.completed(result));
    } catch (e) {
      theSinkVendor.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  signupHall(SignUpHall signUpHall)async{
    debugPrint('signup hall bloc');
    theSinkHall.add(ApiResponse.loading('First Signing'));
    try {
      final SignUpHall result = await _theRepo.signupHall(signUpHall);
      theSinkHall.add(ApiResponse.completed(result));
    } catch (e) {
      theSinkHall.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  dispose() {
    _theControllerUser.close();
    _theControllerVendor.close();
    _theControllerHall.close();
  }
}