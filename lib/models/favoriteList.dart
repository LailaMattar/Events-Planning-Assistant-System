import 'package:event_planning/models/post.dart';
import 'package:flutter/cupertino.dart';

class Favorites {
  late List<Post> favorites;

  Favorites.fromJson(Map<String, dynamic> json) {
    debugPrint('test FavoriteList from json');
    if (json['favorites'].length == 0) {
      debugPrint('favorites null');
      favorites = [];
    } else {
      debugPrint('favorites length: ${json['favorites'].length}');
      debugPrint('favorites not null');
      favorites = List<Post>.from(
          json['favorites'].map((model) => Post.fromJson(model)));
    }
  }
}
