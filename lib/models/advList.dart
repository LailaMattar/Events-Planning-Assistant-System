import 'package:flutter/cupertino.dart';

import 'adv.dart';

class AdvList {
  late List<Adv> adv;

  AdvList.fromJson(Map<String, dynamic> json) {
    debugPrint('AdvList from json');
    if (json['adv'] == null) {
      adv = [];
    } else {
      if (json['adv'].length == 0) {
        debugPrint('AdvList null');
        adv = [];
      } else {
        debugPrint('advlist length: ${json['adv'].length}');
        debugPrint('advlist not null');
        adv = List<Adv>.from(json['adv'].map((model) => Adv.fromJson(model)));
      }
    }
  }
}
