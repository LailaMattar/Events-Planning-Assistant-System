import 'dart:async';

import 'package:event_planning/models/favoriteList.dart';
import 'package:event_planning/models/offers.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/favoriteListRepo.dart';
import 'package:event_planning/repositories/offers_repo.dart';
import 'package:flutter/cupertino.dart';

class FavoriteListBloc {
  late FavoriteListRepo _theRepo;

  late StreamController<ApiResponse<Favorites>> _theController;

  StreamSink<ApiResponse<Favorites>> get theSink => _theController.sink;

  Stream<ApiResponse<Favorites>> get theStream => _theController.stream;

  FavoriteListBloc() {
    _theController = StreamController<ApiResponse<Favorites>>();
    _theRepo = FavoriteListRepo();
  }

  getFavorite() async {
    theSink.add(ApiResponse.loading('getFavorite'));
    try {
      Favorites result = await _theRepo.getFavorite();
      theSink.add(ApiResponse.completed(result));
    } catch (e) {
      theSink.add(ApiResponse.error(e.toString()));
      debugPrint(e.toString());
    }
  }
}
