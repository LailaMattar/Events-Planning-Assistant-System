import 'package:event_planning/models/event.dart';
import 'package:flutter/material.dart';

class AllEvents {
  late List<MyEvent> events;

  AllEvents.fromJson(Map<String, dynamic> json) {
    debugPrint('AllEvents from json');
    if (json['events '].length == 0) {
      debugPrint('events null');
      events = [];
    } else {
      debugPrint('testtt');
      //debugPrint('events length: ${json['events'].length}');
      debugPrint('events not null');
      events = List<MyEvent>.from(
          json['events '].map((model) => MyEvent.fromJson(model)));
    }
  }
}
