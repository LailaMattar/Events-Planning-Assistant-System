import 'dart:async';

import 'package:event_planning/models/gallery.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/offers_repo.dart';
import 'package:event_planning/repositories/upload_gallery_repo.dart';
import 'package:flutter/cupertino.dart';

class UploadGalleryBloc{
  late UploadGalleryRepo _theRepo;

  late StreamController<ApiResponse<Gallery>> _theController;

  StreamSink<ApiResponse<Gallery>> get theSink => _theController.sink;

  Stream<ApiResponse<Gallery>> get theStream => _theController.stream.asBroadcastStream();

  UploadGalleryBloc(){
    _theController = StreamController<ApiResponse<Gallery>>.broadcast();
    _theRepo = UploadGalleryRepo();
  }

  uploadToGallery(Gallery gallery)async{
    debugPrint("yyhhjj");
    theSink.add(ApiResponse.loading('upload to gallery'));
    try{
      Gallery result = await _theRepo.uploadToGallery(gallery);
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }

  uploadToGalleryHall(Gallery gallery)async{
    debugPrint("yyhhjj");
    theSink.add(ApiResponse.loading('upload to gallery hall'));
    try{
      Gallery result = await _theRepo.uploadToGalleryHall(gallery);
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