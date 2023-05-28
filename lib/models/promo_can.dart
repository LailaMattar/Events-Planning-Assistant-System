import 'package:flutter/cupertino.dart';

class PromoCan {
  late int can;

  PromoCan.fromJson(Map<String, dynamic> json) {
    debugPrint('PromoCan fromJson');
    can = json['can'];
  }
}
