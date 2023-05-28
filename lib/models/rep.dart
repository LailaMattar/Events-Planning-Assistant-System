import 'package:event_planning/models/pivot.dart';
import 'package:flutter/cupertino.dart';

class Rep {
  late int vendor_id;
  late String reason;

  Rep.fromJson(Map<String, dynamic> json) {
    debugPrint('rep fromJson');
    vendor_id = json['vendor_id'] ?? 0;
    reason = json['reason'] ?? ' ';
  }

  Rep({required this.vendor_id, required this.reason});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vendor_id'] = vendor_id;
    data['reason'] = reason;
    return data;
  }
}
