import 'dart:async';

import 'package:event_planning/models/advList.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/advRepo.dart';
import 'package:event_planning/repositories/offers_repo.dart';
import 'package:flutter/cupertino.dart';

class AdvBloc {
  late AdvRepo _theRepo;

  late StreamController<ApiResponse<AdvList>> _theController;

  StreamSink<ApiResponse<AdvList>> get theSink => _theController.sink;

  Stream<ApiResponse<AdvList>> get theStream => _theController.stream;

  AdvBloc() {
    _theController = StreamController<ApiResponse<AdvList>>();
    _theRepo = AdvRepo();
  }

  getAdvList() async {
    theSink.add(ApiResponse.loading('Getting AdvList'));
    try {
      AdvList result = await _theRepo.getAdvList();
      theSink.add(ApiResponse.completed(result));
      return result;
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
}
