import 'dart:convert';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class UpdateEventRepo{
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<MyEvent> createEvent(MyEvent event) async {
    debugPrint('create event repo');
    final response = await _helper.put('api/updateEvent', jsonEncode(event.toJsonCreate()));
    return MyEvent.fromJsonType();
  }
}