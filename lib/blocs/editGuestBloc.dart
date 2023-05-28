import 'dart:async';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/guest.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/addGuestRepo.dart';
import 'package:event_planning/repositories/create_event_repo.dart';
import 'package:event_planning/repositories/editGuestRepo.dart';
import 'package:event_planning/repositories/login_repo.dart';
import 'package:event_planning/screens/event_owner/edit_guest.dart';
import 'package:event_planning/screens/event_owner/edit_guest.dart';
import 'package:event_planning/screens/event_owner/edit_guest.dart';
import 'package:event_planning/screens/event_owner/guest_list.dart';
import 'package:flutter/cupertino.dart';

class EditGuestBloc {
  late EditGuestRepo _theRepo;

  late StreamController<ApiResponse<Guest>> _theController;

  StreamSink<ApiResponse<Guest>> get theSink => _theController.sink;

  Stream<ApiResponse<Guest>> get theStream => _theController.stream;

  EditGuestBloc() {
    _theController = StreamController<ApiResponse<Guest>>();
    _theRepo = EditGuestRepo();
  }

  EditGuest(Guest guest, int id) async {
    debugPrint('create event bloc');
    theSink.add(ApiResponse.loading('Create Event'));
    try {
      final Guest result = await _theRepo.EditGuest(guest, id);
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
