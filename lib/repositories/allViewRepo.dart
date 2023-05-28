import 'package:event_planning/models/allBooks.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/cupertino.dart';

class AllViewRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<AllBooks> getAllBooks(String type) async {
    String apiV = '';
    if(state==9){
    if (type == 'all') {
      apiV = 'api/vendor/showbooks';
    } else if (type == 'pending') {
      apiV = 'api/vendor/showbooksfilter/0';
    } else if (type == 'accepted') {
      apiV = 'api/vendor/showbooksfilter/3';
    } else if (type == 'delivered') {
      apiV = 'api/vendor/showbooksfilter/4';
    } else if (type == 'inprogress') {
      apiV = 'api/vendor/showbooksfilter/1';
    }}    if(state==10){

      if (type == 'all') {
      apiV = 'api/vendor/show_book_hall';
    } else if (type == 'pending') {
      apiV = 'api/vendor/show_book_filter_hall/0';
    } else if (type == 'accepted') {
      apiV = 'api/vendor/show_book_filter_hall/3';
    } else if (type == 'delivered') {
      apiV = 'api/vendor/show_book_filter_hall/4';
    } else if (type == 'inprogress') {
      apiV = 'api/vendor/show_book_filter_hall/1';
    }}

    final response = await _helper.get(apiV);
    debugPrint('the body is $response');
    return AllBooks.fromJson(response);
  }
}
