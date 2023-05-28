import 'package:event_planning/models/favoriteList.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class FavoriteListRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Favorites> getFavorite() async {
    final response = await _helper.get('api/showsave');
    debugPrint('the  getFavorite body is $response');
    return Favorites.fromJson(response);
  }
}
