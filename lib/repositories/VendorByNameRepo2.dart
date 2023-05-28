import 'dart:convert';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/hall_profile.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/vendorName.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';

class VendorByNameRepo2 {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<HallProfile> getVendorByName(VendorName vendorName) async {
    debugPrint('cVendorByNameRepo repo');
    final response = await _helper.post(
        'api/getUserProfile', jsonEncode(vendorName.toJson()));
    return HallProfile.fromJson(response);
  }
}
