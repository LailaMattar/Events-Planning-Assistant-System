import 'dart:async';

import 'package:event_planning/models/allBooks.dart';
import 'package:event_planning/models/myres.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/allViewRepo.dart';
import 'package:event_planning/repositories/myResRepo.dart';
import 'package:flutter/cupertino.dart';

class MyResBloc {
  late MyResRepo _theRepo;

  late StreamController<ApiResponse<Myres>> _theController;

  StreamSink<ApiResponse<Myres>> get theSink => _theController.sink;

  Stream<ApiResponse<Myres>> get theStream => _theController.stream;

  MyResBloc() {
    _theController = StreamController<ApiResponse<Myres>>();
    _theRepo = MyResRepo();
  }

  getMyres(int event_id) async {
    theSink.add(ApiResponse.loading('Getting all books'));
    try {
      Myres result = await _theRepo.getMyres(event_id);
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
}
