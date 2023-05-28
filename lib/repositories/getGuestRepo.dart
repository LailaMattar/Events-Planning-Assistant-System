import 'package:event_planning/models/guesllisttt.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class GetGuestRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Guestlisttt> getGuest(int eventid) async {
    final response = await _helper.get('api/showGustsbyIDevent/${eventid}');
    debugPrint('the get offers body is $response');
    return Guestlisttt.fromJson(response);
  }
}
