import 'dart:async';

import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/offers_repo.dart';
import 'package:flutter/cupertino.dart';

class OffersBloc{
  late OffersRepo _theRepo;

  late StreamController<ApiResponse<Offers>> _theController;

  StreamSink<ApiResponse<Offers>> get theSink => _theController.sink;

  Stream<ApiResponse<Offers>> get theStream => _theController.stream;

  OffersBloc(){
    _theController = StreamController<ApiResponse<Offers>>();
    _theRepo = OffersRepo();
  }

  getOffers()async{
    theSink.add(ApiResponse.loading('Getting Vendor Profile'));
    try{
      Offers result = await _theRepo.getOffers();
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
}