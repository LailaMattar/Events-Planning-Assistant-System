import 'package:event_planning/models/allBooks.dart';
import 'package:event_planning/models/myres.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class MyResRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Myres> getMyres(int event_id) async {
    final response = await _helper.get('api/show_book_event/${event_id}');
    debugPrint('the get offers body is $response');
    return Myres.fromJson(response);
  }
}
