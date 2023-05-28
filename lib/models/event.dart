import 'package:flutter/material.dart';

class MyEvent {
  late int id;
  late int user_id;
  late String name;
  late String date;
  late String time;
  late String note;
  late String updated_at;
  late String created_at;

  MyEvent.fromJson(Map<String, dynamic> json) {
    debugPrint('Event fromJson');
    id = json['id'];
    user_id = json['user_id'];
    name = json['name'];
    date = json['date'];
    time = json['time'];
    if (json['note'] == null) {
      debugPrint('note  null');
      note = ' ';
    } else {
      debugPrint('note not null');
      note = json['note'];
    }
    updated_at = json['updated_at'];
    created_at = json['created_at'];
  }

  MyEvent.fromJsonType() {
    //fake
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = user_id;
    data['name'] = name;
    data['time'] = time;
    data['date'] = date;
    data['note'] = note;
    data['updated_at'] = updated_at;
    data['created_at'] = created_at;
    return data;
  }

  Map<String, dynamic> toJsonCreate() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['time'] = time;
    data['date'] = date;
    return data;
  }

  MyEvent(this.name, this.date, this.time);
}
//
// "id": 4,
// "user_id": 28,
// "name": "my wedding",
// "date": "2022-09-09",
// "time": "30:10:00",
// "note": null,
// "created_at": "2022-08-08T22:46:21.000000Z",
// "updated_at": "2022-08-08T22:46:21.000000Z"
