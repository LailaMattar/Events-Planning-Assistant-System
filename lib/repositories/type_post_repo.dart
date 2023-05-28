import 'package:event_planning/models/post.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class TypePostRepo{
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Post> typePost(Post post)async{
    debugPrint('type post repo');
    final response = await _helper.uploadImage('api/vendor/create_post', post);
    return Post.fromJsonType();
  }

  Future<Post> typePostHall(Post post)async{
    debugPrint('type post repo hall');
    final response = await _helper.uploadImage('api/hall/create_post', post);
    return Post.fromJsonType();
  }
}