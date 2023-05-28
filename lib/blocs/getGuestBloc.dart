import 'dart:async';

import 'package:event_planning/models/guesllisttt.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/getGuestRepo.dart';
import 'package:event_planning/repositories/offers_repo.dart';
import 'package:flutter/cupertino.dart';

class GetGuestBloc {
  late GetGuestRepo _theRepo;

  late StreamController<ApiResponse<Guestlisttt>> _theController;

  StreamSink<ApiResponse<Guestlisttt>> get theSink => _theController.sink;

  Stream<ApiResponse<Guestlisttt>> get theStream => _theController.stream;

  GetGuestBloc() {
    _theController = StreamController<ApiResponse<Guestlisttt>>();
    _theRepo = GetGuestRepo();
  }

  getGuest(int eventid) async {
    theSink.add(ApiResponse.loading('Getting Vendor Profile'));
    try {
      Guestlisttt result = await _theRepo.getGuest(eventid);
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
}
