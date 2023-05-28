import 'dart:async';

import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/vendorName.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/CreateBookRepo.dart';
import 'package:event_planning/repositories/vendorByNameRepo.dart';
import 'package:flutter/cupertino.dart';

class VendorByNameBloc {
  late VendorByNameRepo _theRepo;

  late StreamController<ApiResponse<VendorProfile>> _theController;

  StreamSink<ApiResponse<VendorProfile>> get theSink => _theController.sink;

  Stream<ApiResponse<VendorProfile>> get theStream => _theController.stream;

  VendorByNameBloc() {
    _theController = StreamController<ApiResponse<VendorProfile>>();
    _theRepo = VendorByNameRepo();
  }

  getVendorByName(VendorName vendorName) async {
    debugPrint('getVendorByName bloc');
    theSink.add(ApiResponse.loading('Create getVendorByName'));
    try {
      final VendorProfile result = await _theRepo.getVendorByName(vendorName);
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  dispose() {
    _theController.close();
  }
}
