import 'dart:async';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/search.dart';
import 'package:event_planning/models/search_results.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/repositories/create_event_repo.dart';
import 'package:event_planning/repositories/login_repo.dart';
import 'package:event_planning/repositories/searchRepo.dart';
import 'package:flutter/cupertino.dart';

class SearchBloc {
  late SearchRepo _theRepo;

  late StreamController<ApiResponse<SearchResults>> _theController;

  StreamSink<ApiResponse<SearchResults>> get theSink => _theController.sink;

  Stream<ApiResponse<SearchResults>> get theStream => _theController.stream;

  SearchBloc() {
    _theController = StreamController<ApiResponse<SearchResults>>();
    _theRepo = SearchRepo();
  }

  search(Search search) async {
    debugPrint('search bloc');
    debugPrint('type ${search.type} word ${search.word} '
        'max ${search.max_price} min ${search.min_price} city ${search.city} ');
    debugPrint('search bloc');
    theSink.add(ApiResponse.loading('serachhh'));
    try {
      final SearchResults result = await _theRepo.search(search);
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
