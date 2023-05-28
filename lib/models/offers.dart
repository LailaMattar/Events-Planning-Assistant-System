import 'package:event_planning/models/post.dart';
import 'package:flutter/cupertino.dart';

class Offers{
  late List<Post> posts;

  Offers.fromJson(Map<String, dynamic> json){
    debugPrint('test offers from json');
    if(json['posts '].length == 0){
      debugPrint('posts null');
      posts = [];
    }else{
      debugPrint('posts length: ${json['posts '].length}');
      debugPrint('posts not null');
      posts = List<Post>.from(json['posts '].map((model) => Post.fromJson(model)));
    }
  }
}