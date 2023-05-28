import 'dart:async';

import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/promo_can.dart';
import 'package:event_planning/models/rep.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/activePromoRepo.dart';
import 'package:event_planning/repositories/create_event_repo.dart';
import 'package:event_planning/repositories/login_repo.dart';
import 'package:event_planning/repositories/reportRepo.dart';
import 'package:event_planning/screens/event_owner/report.dart';
import 'package:flutter/cupertino.dart';

class ReportBloc {
  late ReportRepo _theRepo;

  late StreamController<ApiResponse<Rep>> _theController;

  StreamSink<ApiResponse<Rep>> get theSink => _theController.sink;

  Stream<ApiResponse<Rep>> get theStream => _theController.stream;

  ReportBloc() {
    _theController = StreamController<ApiResponse<Rep>>();
    _theRepo = ReportRepo();
  }

  report(Rep rep) async {
    debugPrint('ActivePromoBloc bloc');
    theSink.add(ApiResponse.loading('ActivePromoBloc'));
    try {
      final Rep result = await _theRepo.report(rep);
      theSink.add(ApiResponse.completed(result));
      return result;
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  dispose() {
    _theController.close();
  }
}
