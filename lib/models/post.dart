import 'dart:io';

import 'package:event_planning/models/rating.dart';
import 'package:event_planning/models/vendor.dart';
import 'package:flutter/cupertino.dart';

class Post {
  late int id;
  late int vendorId;
  late String type;
  late int save;
  late int accepted;
  late String price2;
  late int price;
  late String description;
  late String title;
  late String updated_at;
  late String imagePost;
  late Vendor vendor;
  late File userFile;
  late List<Rating> rating;

  Post(this.type, this.userFile, this.description, this.title, this.price2);

  Post.id(this.id);

  Post.fromJson(Map<String, dynamic> json) {
    debugPrint('post fromJson');
    id = json['id'];
    id = json['accepted'];
    save = json['save'] ?? 0;
    updated_at = json['updated_at'];
    vendorId = json['vendor_id'] ?? 0;
    if (json['type'] == null) {
      debugPrint('post type null');
      type = ' ';
    } else {
      debugPrint('post type not null');
      type = json['type'] ?? " ";
    }
    debugPrint('post price not null');
    price = json['price'];
    debugPrint('post description not null');
    description = json['description'];
    debugPrint('post titile not null');
    title = json['title'];
    debugPrint('post image post not null');
    imagePost = json['imagepost'] ?? '';
    if (json['vendor'] != null) {
      debugPrint('test vendor null');
      vendor = Vendor.fromJson(json['vendor']);
    }
    if (json['vendor'] == null) {
      debugPrint('test vendor null');
      vendor = Vendor(name: '', profileThumbnail: '', type: '');
    }
    if (json['rating'] == null) {
      rating = [];
    } else {
      if (json['rating'].length == 0) {
        debugPrint('posts null');
        rating = [];
      } else {
        debugPrint('posts length: ${json['rating'].length}');
        debugPrint('posts not null');
        rating = List<Rating>.from(
            json['rating'].map((model) => Rating.fromJson(model)));
      }
    }
  }
  Post.fromJsonType() {
    //fake
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['price'] = price;
    data['description'] = description;
    data['title'] = title;
    data['imagepost'] = userFile;
    return data;
  }
}
