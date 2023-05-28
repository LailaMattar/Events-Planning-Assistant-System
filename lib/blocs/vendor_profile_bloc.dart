import 'dart:async';

import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/vendor_profile_repo.dart';
import 'package:flutter/cupertino.dart';

class VendorProfileBloc{
  late VendorProfileRepo _theRepo;

  late StreamController<ApiResponse<VendorProfile>> _theController;

  StreamSink<ApiResponse<VendorProfile>> get theSink => _theController.sink;

  Stream<ApiResponse<VendorProfile>> get theStream => _theController.stream;

  VendorProfileBloc(){
    _theController = StreamController<ApiResponse<VendorProfile>>();
    _theRepo       = VendorProfileRepo();
  }

  getVendorProfile()async{
    theSink.add(ApiResponse.loading('Getting Vendor Profile'));
    try{
      VendorProfile result = await _theRepo.getProfile();
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }

  getVendorProfileHall()async{
    theSink.add(ApiResponse.loading('Getting Vendor Profile'));
    try{
      VendorProfile result = await _theRepo.getProfileHall();
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }

  getVendorProfileById(int id)async{
    theSink.add(ApiResponse.loading('Getting Vendor Profile By Id'));
    try{
      VendorProfile result = await _theRepo.getProfileById(id);
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }

  getHallProfileById(int id)async{
    theSink.add(ApiResponse.loading('Getting Vendor Profile By Id'));
    try{
      VendorProfile result = await _theRepo.getProfileHallById(id);
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
  dispose(){
    _theController.close();
  }
}