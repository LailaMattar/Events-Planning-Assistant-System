import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class OffersRepo{
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Offers> getOffers()async{
    final response = await _helper.get('api/show_posts_offer');
    debugPrint('the get offers body is $response');
    return Offers.fromJson(response);
  }
}