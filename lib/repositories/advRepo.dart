import 'package:event_planning/models/advList.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class AdvRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<AdvList> getAdvList() async {
    final response = await _helper.get('api/showPublicity');
    debugPrint('showPublicity body is $response');
    return AdvList.fromJson(response);
  }
}
