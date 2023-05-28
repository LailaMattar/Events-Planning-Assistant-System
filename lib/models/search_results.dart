import 'package:event_planning/models/hall_profile.dart';
import 'package:event_planning/models/post.dart';
import 'package:event_planning/models/vendor_profile.dart';
import 'package:flutter/cupertino.dart';

class SearchResults {
  late List<VendorProfile> filteredvendor = [];
  late List<Post> filteredposts = [];
  late List<HallProfile> filteredhall = [];

  SearchResults();

  SearchResults.fromJson(Map<String, dynamic> json) {
    debugPrint('filteredvendor from json');
    if (json['filteredvendor'].length == 0) {
      debugPrint('filteredvendor null');
      filteredvendor = [];
    } else {
      debugPrint('filteredvendor length: ${json['filteredvendor'].length}');
      debugPrint('filteredvendor not null');
      filteredvendor = List<VendorProfile>.from(
          json['filteredvendor'].map((model) => VendorProfile.fromJson(model)));
    }

    debugPrint('filteredposts from json');
    if (json['filteredposts'].length == 0) {
      debugPrint('filteredposts null');
      filteredposts = [];
    } else {
      debugPrint('filteredposts length: ${json['filteredposts'].length}');
      debugPrint('filteredposts not null');
      filteredposts = List<Post>.from(
          json['filteredposts'].map((model) => Post.fromJson(model)));
    }

    debugPrint('filteredhall from json');
    if (json['filteredhall'].length == 0) {
      debugPrint('filteredhall null');
      filteredhall = [];
    } else {
      debugPrint('filteredhall length: ${json['filteredhall'].length}');
      debugPrint('filteredhall not null');
      filteredhall = List<HallProfile>.from(
          json['filteredhall'].map((model) => HallProfile.fromJson(model)));
    }
  }
}
