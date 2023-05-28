import 'package:event_planning/models/all_events.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/material.dart';

class EventsRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<AllEvents> getMyEvents() async {
    final response = await _helper.get('api/get_all_events');
    debugPrint('the body is $response');
    return AllEvents.fromJson(response);
  }
}
