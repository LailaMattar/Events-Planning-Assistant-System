import 'package:event_planning/models/pivot.dart';
import 'package:flutter/cupertino.dart';

class Rep2 {
  late int user_id;
  late String reason;

  Rep2.fromJson(Map<String, dynamic> json) {
    debugPrint('rep fromJson');
    user_id = json['user_id'] ?? 0;
    reason = json['reason'] ?? ' ';
  }

  Rep2({required this.user_id, required this.reason});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user_id;
    data['reason'] = reason;
    return data;
  }
}
