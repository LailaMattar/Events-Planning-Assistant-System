import 'dart:async';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/guest.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/addGuestRepo.dart';
import 'package:event_planning/repositories/create_event_repo.dart';
import 'package:event_planning/repositories/login_repo.dart';
import 'package:event_planning/screens/event_owner/guest_list.dart';
import 'package:flutter/cupertino.dart';

class AddGuestBloc {
  late AddGuestRepo _theRepo;

  late StreamController<ApiResponse<Guest>> _theController;

  StreamSink<ApiResponse<Guest>> get theSink => _theController.sink;

  Stream<ApiResponse<Guest>> get theStream => _theController.stream;

  AddGuestBloc() {
    _theController = StreamController<ApiResponse<Guest>>();
    _theRepo = AddGuestRepo();
  }

  AddGuest(Guest guest, int event_id) async {
    debugPrint('create event bloc');
    theSink.add(ApiResponse.loading('Create Event'));
    try {
      final Guest result = await _theRepo.AddGuest(guest, event_id);
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  dispose() {
    _theController.close();
  }
}
