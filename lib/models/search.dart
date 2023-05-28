import 'package:flutter/material.dart';

class Search {
  late String word;
  late String city;
  late String type;
  late String min_price;
  late String max_price;

  Search(
      {required this.word,
      required this.city,
      required this.type,
      required this.min_price,
      required this.max_price});

  Search.fromJsonType() {
    //fake
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (word == "") {
      data['word'] = null;
    } else {
      data['word'] = word;
    }
    if (city == 'Location') {
      data['city'] = null;
    } else {
      data['city'] = city;
    }
    if (data['type'] == "Type") {
      data['type'] = null;
    } else {
      data['type'] = type;
    }
    if (data['min_price'] == 'From price') {
      data['min_price'] = null;
    } else {
      data['min_price'] = min_price;
    }
    if (data['max_price'] == 'To price') {
      data['max_price'] = null;
    } else {
      data['max_price'] = max_price;
    }
    return data;
  }
}
