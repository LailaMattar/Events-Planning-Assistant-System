import 'package:event_planning/models/post.dart';
import 'package:flutter/cupertino.dart';

import 'image.dart';

class VendorCard {
  late int id;
  late String name;
  late String type;
  late String gender;
  late String email;
  late String email_verified_at;
  late String password;
  late String profile_thumbnail;
  late String city;
  late String about;
  late String since;
  late String to;
  late String phone_number;
  late String remember_token;
  late String updated_at;
  late String created_at;
  late int period_of_book;
  late int forbiddin;
  late List<Post> posts;
  late List<ImageGallery> images;

  VendorCard.fromJson(Map<String, dynamic> json) {
    debugPrint('vendorcard fromJson');
    id = json['id'] ?? ' ';
    period_of_book = json['period_of_book'] ?? ' ';
    updated_at = json['updated_at'] ?? ' ';
    created_at = json['created_at'] ?? ' ';
    forbiddin = json['forbiddin'] ?? ' ';
    name = json['name'] ?? ' ';
    type = json['type'] ?? ' ';
    gender = json['gendre'] ?? ' ';
    profile_thumbnail = json['profile_thumbnail'] ?? ' ';
    about = json['about'] ?? ' ';
    email_verified_at = json['email_verified_at'] ?? ' ';
    email = json['email'] ?? ' ';
    city = json['city'] ?? ' ';
    phone_number = json['phone_number'] ?? ' ';
    remember_token = json['remember_token'] ?? ' ';
    since = json['since'] ?? ' ';
    to = json['to'] ?? ' ';
    if (json['posts'] == null) {
      debugPrint('posts null');
      posts = [];
    } else {
      debugPrint('posts length: ${json['posts'].length}');
      debugPrint('posts not null');
      posts =
          List<Post>.from(json['posts'].map((model) => Post.fromJson(model)));
    }
    if (json['images'] == null) {
      images = [];
    } else {
      images = List<ImageGallery>.from(
          json['images'].map((model) => ImageGallery.fromJson(model)));
    }
  }
}
