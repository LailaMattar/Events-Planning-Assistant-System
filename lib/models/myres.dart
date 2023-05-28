import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/vendor_card.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:flutter/material.dart';

class Myres {
  late List<Book> myres;
  late List<VendorProfile> vendors;

  Myres.fromJson(Map<String, dynamic> json) {
    debugPrint('allBooks from json');
    if (json['book '] == null) {
      myres = [];
    } else {
      if (json['book '].length == 0) {
        debugPrint('allBooks null');
        myres = [];
      } else {
        debugPrint('myres');
        // debugPrint('AllVendors length: ${json['vendors'].vendors.length}');
        debugPrint('allBooks not null');
        myres =
            List<Book>.from(json['book '].map((model) => Book.fromJson(model)));
      }
    }
    if (json['vendors'] == null) {
      vendors = [];
    } else {
      if (json['vendors'].length == 0) {
        debugPrint('allBooks null');
        vendors = [];
      } else {
        debugPrint('vendors');
        // debugPrint('AllVendors length: ${json['vendors'].vendors.length}');
        debugPrint('allBooks not null');
        vendors = List<VendorProfile>.from(
            json['vendors'].map((model) => VendorProfile.fromJson(model)));
      }
    }
  }
}
