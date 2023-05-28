import 'dart:async';

import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/models/save_post.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/CreateBookRepo.dart';
import 'package:event_planning/repositories/savePostRepo.dart';
import 'package:event_planning/repositories/unsavePostRepo.dart';
import 'package:flutter/cupertino.dart';

class UnSavePostBloc {
  late UnSavePostRepo _theRepo;

  late StreamController<ApiResponse<SavePost>> _theController;

  StreamSink<ApiResponse<SavePost>> get theSink => _theController.sink;

  Stream<ApiResponse<SavePost>> get theStream => _theController.stream;

  UnSavePostBloc() {
    _theController = StreamController<ApiResponse<SavePost>>();
    _theRepo = UnSavePostRepo();
  }

  unsavePost(SavePost post) async {
    debugPrint('unsave post bloc');
    theSink.add(ApiResponse.loading('unsave post'));
    try {
      final SavePost result = await _theRepo.unsavePost(post);
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
