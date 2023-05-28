import 'dart:async';

import 'package:event_planning/models/copoun.dart';
import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/promo_can.dart';
import 'package:event_planning/models/rep.dart';
import 'package:event_planning/models/rep2.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/activePromoRepo.dart';
import 'package:event_planning/repositories/create_event_repo.dart';
import 'package:event_planning/repositories/login_repo.dart';
import 'package:event_planning/repositories/reportRepo.dart';
import 'package:event_planning/repositories/reportRepo2.dart';
import 'package:event_planning/screens/event_owner/report.dart';
import 'package:flutter/cupertino.dart';

class ReportBloc2 {
  late ReportRepo2 _theRepo;

  late StreamController<ApiResponse<Rep2>> _theController;

  StreamSink<ApiResponse<Rep2>> get theSink => _theController.sink;

  Stream<ApiResponse<Rep2>> get theStream => _theController.stream;

  ReportBloc2() {
    _theController = StreamController<ApiResponse<Rep2>>();
    _theRepo = ReportRepo2();
  }

  report(Rep2 rep) async {
    debugPrint('ActivePromoBloc bloc');
    theSink.add(ApiResponse.loading('ActivePromoBloc'));
    try {
      final Rep2 result = await _theRepo.report(rep);
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
