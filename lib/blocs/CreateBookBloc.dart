import 'dart:async';

import 'package:event_planning/models/book.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/CreateBookRepo.dart';
import 'package:flutter/cupertino.dart';

class CreateBookBloc {
  late CreateBookRepo _theRepo;

  late StreamController<ApiResponse<Book>> _theController;

  StreamSink<ApiResponse<Book>> get theSink => _theController.sink;

  Stream<ApiResponse<Book>> get theStream => _theController.stream;

  CreateBookBloc() {
    _theController = StreamController<ApiResponse<Book>>();
    _theRepo = CreateBookRepo();
  }

  createBook(Book book, int post_id) async {
    debugPrint('create book bloc');
    theSink.add(ApiResponse.loading('Create book'));
    try {
      final Book result = await _theRepo.createBook(book, post_id);
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  getBookDays(int vendorId) async {
    debugPrint('create book bloc');
    theSink.add(ApiResponse.loading('Create book'));
    try {
      final Book result = await _theRepo.getBookDays(vendorId);
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  dispose() {
    debugPrint("dispoooose");
    _theController.close();
  }
}
