import 'package:event_planning/models/all_vendors.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class allVendorRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<AllVendors> getAllVendors(String type) async {
    final response = await _helper.get('api/get-vendor-bytype/$type');
    debugPrint('the body is $response');
    return AllVendors.fromJson(response);
  }
}
