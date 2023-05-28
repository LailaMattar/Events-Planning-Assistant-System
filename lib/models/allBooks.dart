import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/vendor_card.dart';
import 'package:flutter/material.dart';

class AllBooks {
  late List<Book> allBooks;

  AllBooks.fromJson(Map<String, dynamic> json) {
    debugPrint('allBooks from json');

    if (json['allbook '].length == 0) {
      debugPrint('allBooks null');
      allBooks = [];
    } else {
      debugPrint('testtt');
      // debugPrint('AllVendors length: ${json['vendors'].vendors.length}');
      debugPrint('allBooks not null');
      allBooks = List<Book>.from(
          json['allbook '].map((model) => Book.fromJson(model)));
    }
  }
}
