import 'dart:async';

import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/status_book_repo.dart';
import 'package:event_planning/repositories/type_post_repo.dart';
import 'package:flutter/cupertino.dart';

class StatusBookBloc{
  late StatusBookRepo _theRepo;

  late StreamController<ApiResponse<Book>> _theController;

  StreamSink<ApiResponse<Book>> get theSink => _theController.sink;

  Stream<ApiResponse<Book>> get theStream => _theController.stream;

  StatusBookBloc(){
    _theController = StreamController<ApiResponse<Book>>();
    _theRepo = StatusBookRepo();
  }

  makeBookAccept(int bookId)async{
    theSink.add(ApiResponse.loading('make book accept'));
    try{
      var result = await _theRepo.makeBookAccept(bookId);
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }

  makeBookInProgress(int bookId)async{
    debugPrint("testkkkk");
    theSink.add(ApiResponse.loading('make book in progress'));
    try{
      var result = await _theRepo.makeBookInProgress(bookId);
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }

  makeBookFail(int bookId)async{
    theSink.add(ApiResponse.loading('make book fail'));
    try{
      var result = await _theRepo.makeBookFail(bookId);
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }

  makeBookDelivered(int bookId)async{
    theSink.add(ApiResponse.loading('make book fail'));
    try{
      var result = await _theRepo.makeBookDelivered(bookId);
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }

  makeBookHallAccept(int bookId)async{
    theSink.add(ApiResponse.loading('make book hall accept'));
    try{
      var result = await _theRepo.makeBookDelivered(bookId);
      theSink.add(ApiResponse.completed(result));
    }catch(e){
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }

  dispose() {
    _theController.close();
  }
}