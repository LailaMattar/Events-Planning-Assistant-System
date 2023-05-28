import 'dart:convert';

import 'package:event_planning/models/event.dart';
import 'package:event_planning/models/login.dart';
import 'package:event_planning/models/search.dart';
import 'package:event_planning/models/search_results.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';

class SearchRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<SearchResults> search(Search search) async {
    debugPrint('search repo');
    final response =
        await _helper.post('api/search', jsonEncode(search.toJson()));
    return SearchResults.fromJson(response);
  }
}
