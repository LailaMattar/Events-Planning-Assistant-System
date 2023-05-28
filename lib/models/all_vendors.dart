import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/vendor_card.dart';
import 'package:flutter/material.dart';

class AllVendors {
  late List<VendorCard> vendors;

  AllVendors.fromJson(Map<String, dynamic> json) {
    debugPrint('AllVendors from json');
    if (json['vendors '].length == 0) {
      debugPrint('all vendors null');
      vendors = [];
    } else {
      debugPrint('testtt');
      // debugPrint('AllVendors length: ${json['vendors'].vendors.length}');
      debugPrint('vendors not null');
      vendors = List<VendorCard>.from(
          json['vendors '].map((model) => VendorCard.fromJson(model)));
    }
  }
}
