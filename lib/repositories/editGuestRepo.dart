import 'dart:convert';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/guest.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/screens/event_owner/guest_list.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';

class EditGuestRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Guest> EditGuest(Guest guest, int id) async {
    debugPrint('tttt');
    debugPrint('${guest.name} ${guest.phone_number}');
    final response = await _helper.post(
        'api/updategust/${id}', jsonEncode(guest.toJsonCreate()));
    return Guest.fromJsonType();
  }
}
