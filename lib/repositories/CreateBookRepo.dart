import 'dart:convert';

import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';

class CreateBookRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Book> createBook(Book book, int post_id) async {
    debugPrint('create book repo');
    final response = await _helper.post(
        'api/create_book/$post_id', jsonEncode(book.toJson()));
    debugPrint('test book response ${response.toString()}');
    return Book.fromJsonType();
  }

  Future<Book> getBookDays(int vendorId) async {
    debugPrint('create book repo');
    final response = await _helper.get(
        'api/showCalander/$vendorId');
    debugPrint('test book response ${response.toString()}');
    return Book.fromJsonDays(response);
  }
}
