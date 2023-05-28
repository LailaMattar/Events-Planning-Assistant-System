import 'dart:async';

import 'package:event_planning/models/book.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/models/save_post.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/CreateBookRepo.dart';
import 'package:event_planning/repositories/savePostRepo.dart';
import 'package:flutter/cupertino.dart';

class SavePostBloc {
  late SavePostRepo _theRepo;

  late StreamController<ApiResponse<SavePost>> _theController;

  StreamSink<ApiResponse<SavePost>> get theSink => _theController.sink;

  Stream<ApiResponse<SavePost>> get theStream => _theController.stream;

  SavePostBloc() {
    _theController = StreamController<ApiResponse<SavePost>>();
    _theRepo = SavePostRepo();
  }

  savePost(SavePost post) async {
    debugPrint('save post bloc');
    theSink.add(ApiResponse.loading('save post'));
    try {
      final SavePost result = await _theRepo.savePost(post);
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  disspose() {
    _theController.close();
  }
}
