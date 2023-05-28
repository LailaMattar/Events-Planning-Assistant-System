import 'dart:io';

import 'package:event_planning/models/vendor.dart';
import 'package:flutter/cupertino.dart';

class SavePost {
  late int post_id;

  SavePost.fromJson(Map<String, dynamic> json) {
    debugPrint('SavePost fromJson');
    post_id = json['post_id'];
  }

  SavePost(this.post_id);

  SavePost.fromJsonType() {
    //fake
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = post_id;
    return data;
  }
}
