import 'package:event_planning/models/rating.dart';
import 'package:flutter/cupertino.dart';

class AllRating {
  late List<Rating> rating;

  AllRating.fromJson(Map<String, dynamic> json) {
    debugPrint('AllRating from json');
    if (json['rating'] == null) {
      rating = [];
    } else {
      if (json['rating'].length == 0) {
        debugPrint('rating null');
        rating = [];
      } else {
        debugPrint('Rating length: ${json['rating'].length}');
        debugPrint('Rating not null');
        rating = List<Rating>.from(
            json['rating'].map((model) => Rating.fromJson(model)));
      }
    }
  }
}
