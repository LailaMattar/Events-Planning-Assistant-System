import 'package:event_planning/models/book.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class StatusBookRepo{
  final ApiBaseHelper _helper = ApiBaseHelper();
  Future<Book> makeBookAccept(int bookId) async {
    final response =
    await _helper.get('api/vendor/acceptbook/$bookId');
    debugPrint('save post response ${response.toString()}');
    return Book.fromJsonStatus(response);
  }

  Future<Book> makeBookInProgress(int bookId) async {
    print("in progress repo : ");
    final response =
    await _helper.get('api/vendor/inprogress/$bookId');
    debugPrint('save post response ${response.toString()}');
    return Book.fromJsonStatus(response);
  }

  Future<Book> makeBookFail(int bookId) async {
    final response =
    await _helper.get('api/vendor/fail_book/$bookId');
    debugPrint('save post response ${response.toString()}');
    return Book.fromJsonStatus(response);
  }

  Future<Book> makeBookDelivered(int bookId) async {
    final response =
    await _helper.get('api/vendor/deleverd/$bookId');
    debugPrint('save post response ${response.toString()}');
    return Book.fromJsonStatus(response);
  }

  Future<Book> makeBookHallAccept(int bookId) async {
    final response =
    await _helper.get('api/vendor/inprogresshall/$bookId');
    debugPrint('save post response ${response.toString()}');
    return Book.fromJsonStatus(response);
  }
}