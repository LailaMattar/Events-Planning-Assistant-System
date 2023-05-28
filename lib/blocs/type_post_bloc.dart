import 'dart:async';

import 'package:event_planning/models/post.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/type_post_repo.dart';
import 'package:flutter/cupertino.dart';

class TypePostBloc{
  late TypePostRepo _theRepo;

  late StreamController<ApiResponse<Post>> _theController;

  StreamSink<ApiResponse<Post>> get theSink => _theController.sink;

  Stream<ApiResponse<Post>> get theStream => _theController.stream;

  TypePostBloc(){
    _theController = StreamController<ApiResponse<Post>>();
    _theRepo = TypePostRepo();
  }

  typePost(Post post)async{
    theSink.add(ApiResponse.loading('Getting Vendor Profile'));
    try{
      var result = await _theRepo.typePost(post);
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }

  typePostHall(Post post)async{
    theSink.add(ApiResponse.loading('Getting Vendor Profile'));
    try{
      var result = await _theRepo.typePostHall(post);
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
}