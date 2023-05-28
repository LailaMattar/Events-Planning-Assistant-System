import 'package:flutter/cupertino.dart';

class Rating {
  late int id;

  Rating();

  late int user_id;

  late int post_id;

  late String rating;

  late String rating_text;
  late String user_name;

  late String created_at;

  late String updated_at;

  Rating.fromJson(Map<String, dynamic> json) {
    debugPrint('post fromJson');
    debugPrint('sss');
    id = json['id'];
    debugPrint('2');

    rating = json['rating'] ?? "0";
    debugPrint('3');
    post_id = json['post_id'];
    debugPrint('3');
    user_id = json['user_id'];
    debugPrint('4');
    rating_text = json['rating_text'] ?? '';
    debugPrint('5');
    user_name = json['user_name'] ?? '';
    debugPrint('6');
    created_at = json['created_at'] ?? '';
    debugPrint('7');
    updated_at = json['updated_at'] ?? '';
  }
  Rating.fromJsonType() {
    //fake
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['post_id'] = post_id;
    data['user_id'] = user_id;
    data['rating_text'] = rating_text;
    data['rating'] = rating;
    data['created_at'] = created_at;
    data['user_name'] = user_name;
    data['updated_at'] = updated_at;
    return data;
  }
}
