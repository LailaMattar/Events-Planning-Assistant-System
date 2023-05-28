import 'package:flutter/cupertino.dart';

class Pivot {
  late int user_id;
  late int copun_id;
  late String created_at;
  late String updated_at;

  Pivot.fromJson(Map<String, dynamic> json) {
    debugPrint('pivot fromJson');
    user_id = json['user_id'];
    copun_id = json['copun_id'];
    created_at = json['id'] ?? ' ';
    updated_at = json['updated_at'] ?? ' ';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user_id;
    data['copun_id'] = copun_id;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    return data;
  }
}
