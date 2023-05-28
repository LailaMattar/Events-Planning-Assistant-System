import 'dart:async';

import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/hall_profile.dart';
import 'package:event_planning/models/vendorName.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/CreateBookRepo.dart';
import 'package:event_planning/repositories/VendorByNameRepo2.dart';
import 'package:event_planning/repositories/vendorByNameRepo.dart';
import 'package:flutter/cupertino.dart';

class VendorByNameBloc2 {
  late VendorByNameRepo2 _theRepo;

  late StreamController<ApiResponse<HallProfile>> _theController;

  StreamSink<ApiResponse<HallProfile>> get theSink => _theController.sink;

  Stream<ApiResponse<HallProfile>> get theStream => _theController.stream;

  VendorByNameBloc2() {
    _theController = StreamController<ApiResponse<HallProfile>>();
    _theRepo = VendorByNameRepo2();
  }

  getVendorByName(VendorName vendorName) async {
    debugPrint('getVendorByName bloc');
    theSink.add(ApiResponse.loading('Create getVendorByName'));
    try {
      final HallProfile result = await _theRepo.getVendorByName(vendorName);
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
