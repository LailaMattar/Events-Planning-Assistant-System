import 'package:flutter/material.dart';

class Book {
  late String fullname;
  late String description;
  late String event_date;
  late String edit;
  late String created_at;
  late String updated_at;
  late int period_of_book;
  late String photo;
  late int event_id;
  int post_id = 0;
  int hall_id = 0;
  int user_id = 0;
  int vendor_id = 0;
  int day_of_book_id = 0;
  int id = 0;
  int status_of_book = 0;
  late List<String> days;
  late int userId;
  late String image;

  Book(
      {required this.fullname,
      required this.description,
      required this.event_date,
      required this.event_id});

  Book.fromJson(Map<String, dynamic> json) {
    if (json['hall_id'] == null) {
      debugPrint('hall_id null');
      hall_id = 0;
    } else {
      debugPrint('hall_id not null');
      hall_id = json['hall_id'];
    }
    if (json['status_of_book'] == null) {
      debugPrint('status_of_book null');
      status_of_book = 0;
    } else {
      debugPrint('hall_id not status_of_book');
      status_of_book = json['status_of_book'];
    }

    event_id = json['event_id'] ?? 0;
    day_of_book_id = json['day_of_book_id'] ?? 0;
    vendor_id = json['vendor_id'] ?? 0;
    user_id = json['user_id'] ?? 0;
    edit = json['edit'] ?? " ";
    id = json['id'] ?? 0;
    post_id = json['post_id'];
    fullname = json['fullname'];
    created_at = json['created_at'] ?? " ";
    updated_at = json['updated_at'] ?? " ";
    photo = json['photo'] ?? " ";
    photo = json['photo'] ?? " ";
    description = json['description'];
    event_date = json['event_date'];
    userId = json['user_id'];
    image = json['photo'];
  }

  Book.fromJsonType() {
    //fake
  }

  Book.fromJsonDays(Map<String, dynamic> json) {
    if (json['day'].length == 0) {
      days = [];
    } else {
      days =
          List<String>.from(json['day'].map((model) => model['day_of_book']));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['description'] = description;
    data['event_date'] = event_date;
    data['event_id'] = event_id;
    data['status_of_book'] = status_of_book;
    data['hall_id'] = hall_id;
    data['id'] = id;
    data['post_id'] = post_id;
    return data;
  }

  Book.fromJsonStatus(int json){
    status_of_book = json;
  }
}
