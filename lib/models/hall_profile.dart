import 'package:event_planning/models/post.dart';
import 'package:flutter/cupertino.dart';

import 'image.dart';

class HallProfile {
  late int id;
  late int period_of_book;
  late int forbiddin;
  late String name;
  late String type;
  late String gender;
  late String profileThumbnail;
  late String city;
  late String email_verified_at;
  late String password;
  late String about;
  late int number_of_client;
  late String phone_number;
  late int max_number_of_person;
  late int min_number_of_person;
  late String since;
  late String created_at;
  late String updated_at;
  late String remember_token;
  late String to;
  late List<Post> posts;
  late List<Post> offers;
  late List<ImageGallery> images;

  late List<String> days;
  HallProfile.fromJson(Map<String, dynamic> json) {
    debugPrint('hall profile fromJson');
    debugPrint('hall name fromJson');
    name = json['name'] ?? ' ';
    email_verified_at = json['email_verified_at'] ?? ' ';
    created_at = json['created_at'] ?? ' ';
    updated_at = json['updated_at'] ?? ' ';
    password = json['password'] ?? ' ';
    debugPrint('hall 2 fromJson');

    remember_token = json['remember_token'] ?? ' ';
    phone_number = json['phone_number'];
    max_number_of_person = json['max_number_of_person'];
    min_number_of_person = json['min_number_of_person'];
    debugPrint('hall 3 fromJson');

    id = json['id'];
    number_of_client = json['number_of_client'] ?? 0;
    debugPrint('hall 4fromJson');

    period_of_book = json['period_of_book'];
    forbiddin = json['forbiddin'];
    debugPrint('hall 5 fromJson');

    type = json['type'] ?? ' ';
    debugPrint('hall 6 fromJson');

    gender = json['gendre'] ?? ' ';
    debugPrint('hall 7 fromJson');

    profileThumbnail = json['profile_thumbnail'] ?? ' ';
    debugPrint('hall 8 fromJson');

    about = json['about'] ?? ' ';
    debugPrint('hall 9 fromJson');

    city = json['city'] ?? ' ';
    debugPrint('hall 10 fromJson');

    since = json['since'] ?? ' ';
    debugPrint('hall 6 fromJson');

    to = json['to'] ?? ' ';
    debugPrint('hall 11 fromJson');

    if (json['normal'] == null) {
      posts = [];
    } else {
      if (json['normal'].length == 0) {
        debugPrint('posts null');
        posts = [];
      } else {
        debugPrint('posts not null');
        debugPrint('posts length: ${json['normal'].length}');
        posts = List<Post>.from(
            json['normal'].map((model) => Post.fromJson(model)));
      }
    }

    if (json['offer'] == null) {
      offers = [];
    } else {
      if (json['offer'].length == 0) {
        debugPrint('posts null');
        offers = [];
      } else {
        debugPrint('posts not null');
        debugPrint('posts length: ${json['offer'].length}');
        offers =
            List<Post>.from(json['offer'].map((model) => Post.fromJson(model)));
      }
    }

    if (json['images'] == null) {
      images = [];
    } else {
      if (json['images'].length == 0) {
        images = [];
      } else {
        images = List<ImageGallery>.from(
            json['images'].map((model) => ImageGallery.fromJson(model)));
      }
    }

    if (json['day_of_book'] == null) {
      days = [];
    } else {
      if (json['day_of_book'].length == 0) {
        days = [];
      } else {
        days = List<String>.from(
            json['day_of_book'].map((model) => model['day_of_book']));
      }
    }
  }
}
