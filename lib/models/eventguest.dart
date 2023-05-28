import 'package:event_planning/models/ggguest.dart';
import 'package:flutter/cupertino.dart';

class EventGuest {
  late int id;
  late int user_id;
  late String name;
  late String date;
  late String time;
  late String note;
  late String created_at;
  late String updated_at;
  late List<GuestInfo> guest;

  EventGuest.fromJson(Map<String, dynamic> json) {
    debugPrint('test offers from json');

    id = json['id'];
    user_id = json['user_id'];
    updated_at = json['updated_at'] ?? '';
    name = json['name'] ?? '';
    date = json['date'] ?? '';
    time = json['time'] ?? '';
    note = json['note'] ?? '';
    created_at = json['created_at'] ?? '';

    if (json['guest'] == null) {
      guest = [];
    } else {
      if (json['guest'].length == 0) {
        debugPrint('guest null');
        guest = [];
      } else {
        debugPrint('guest length: ${json['guest'].length}');
        debugPrint('guest not null');
        guest = List<GuestInfo>.from(
            json['guest'].map((model) => GuestInfo.fromJson(model)));
      }
    }
  }
}
