import 'package:event_planning/models/post.dart';
import 'package:flutter/cupertino.dart';

import 'image.dart';

class VendorProfile {
  late String name;
  late String fcm;
  late String type;
  late String gender;
  late String profileThumbnail;
  late int period_of_book;
  late String email_verified_at;
  late String remember_token;
  late String city;
  late String about;
  late String since;
  late String to;
  late String phone_number;
  late int id;
  late int forbiddin;
  late List<Post> posts;
  late List<Post> offers;
  late List<Post> hospitality;
  late List<ImageGallery> images;
  late List<String> days;

  VendorProfile.fromJson(Map<String, dynamic> json) {
    debugPrint('vendorProfile fromJson');
    name = json['name'] ?? ' ';
    debugPrint('1');

    email_verified_at = json['email_verified_at'] ?? ' ';
    debugPrint('1');

    fcm = json['fcm'] ?? ' ';
    debugPrint('2');
    remember_token = json['remember_token'] ?? ' ';
    debugPrint('3');
    phone_number = json['phone_number'] ?? ' ';
    debugPrint('4');
    type = json['type'] ?? ' ';
    debugPrint('5');
    id = json['id'] ?? 0;
    debugPrint('6');
    forbiddin = json['forbiddin'] ?? 0;
    debugPrint('7');
    period_of_book = json['period_of_book'] ?? 0;
    debugPrint('8');
    gender = json['gendre'] ?? ' ';
    debugPrint('9');
    debugPrint('10');
    debugPrint('1');
    profileThumbnail = json['profile_thumbnail'] ?? ' ';
    debugPrint('11');
    debugPrint('1');
    debugPrint('1');
    about = json['about'] ?? ' ';
    city = json['city'] ?? ' ';
    debugPrint('12');
    since = json['since'] ?? ' ';
    debugPrint('13');
    to = json['to'] ?? ' ';
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
    debugPrint('14');

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

  VendorProfile.fromJsonSala(Map<String, dynamic> json) {
    debugPrint('sala Profile fromJson');
    name = json['name '] ?? ' ';
    email_verified_at = json['email_verified_at '] ?? ' ';
    remember_token = json['remember_token '] ?? ' ';
    type = json['type'] ?? ' ';
    id = json['id'] ?? 0;
    gender = json['gendre'] ?? ' ';
    profileThumbnail = json['profile_thumbnail'] ?? ' ';
    about = json['about'] ?? ' ';
    city = json['city'] ?? ' ';
    since = json['since'] ?? ' ';
    to = json['to'] ?? ' ';
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
    if (json['day_of_book'].length == 0) {
      days = [];
    } else {
      days = List<String>.from(
          json['day_of_book'].map((model) => model['day_of_book']));
    }
    if(json['hospitality'].length == 0){
      hospitality = [];
    }else{
      hospitality = List<Post>.from(
          json['hospitality'].map((model) => Post.fromJson(model)));
    }
  }
}
