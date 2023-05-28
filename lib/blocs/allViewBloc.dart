import 'dart:async';

import 'package:event_planning/models/allBooks.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/allViewRepo.dart';
import 'package:flutter/cupertino.dart';

class AllViewBloc {
  late AllViewRepo _theRepo;

  late StreamController<ApiResponse<AllBooks>> _theController;

  StreamSink<ApiResponse<AllBooks>> get theSink => _theController.sink;

  Stream<ApiResponse<AllBooks>> get theStream => _theController.stream;

  AllViewBloc() {
    _theController = StreamController<ApiResponse<AllBooks>>();
    _theRepo = AllViewRepo();
  }

  getAllBooks(String type) async {
    theSink.add(ApiResponse.loading('Getting all books'));
    try {
      AllBooks result = await _theRepo.getAllBooks(type);
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
}
