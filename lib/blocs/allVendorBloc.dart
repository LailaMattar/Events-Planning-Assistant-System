import 'dart:async';

import 'package:event_planning/models/all_vendors.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/allVendorRepo.dart';
import 'package:event_planning/repositories/offers_repo.dart';
import 'package:flutter/cupertino.dart';

class allVendorBloc {
  late allVendorRepo _theRepo;

  late StreamController<ApiResponse<AllVendors>> _theController;

  StreamSink<ApiResponse<AllVendors>> get theSink => _theController.sink;

  Stream<ApiResponse<AllVendors>> get theStream => _theController.stream;

  allVendorBloc() {
    _theController = StreamController<ApiResponse<AllVendors>>();
    _theRepo = allVendorRepo();
  }

  getAllVendors(String type) async {
    theSink.add(ApiResponse.loading('Getting all vendors'));
    try {
      AllVendors result = await _theRepo.getAllVendors(type);
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
}
