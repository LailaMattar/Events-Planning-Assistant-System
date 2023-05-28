import 'package:event_planning/models/pivot.dart';
import 'package:flutter/cupertino.dart';

class Coupon {
  late int id;
  late String datefinish;
  late int period_of_copun;
  late int amount;
  late int admin_id;
  late int state;
  late String type;
  late String code_owner;
  late String created_at;
  late String updated_at;
  late double postprice;
  late Pivot pivot;

  Coupon.pricefromJson(Map<String, dynamic> json) {
    postprice = json['postprice'] ?? 0.0;
  }

  Coupon.fromJson(Map<String, dynamic> json) {
    debugPrint('Coupon fromJson');
    id = json['id'];
    datefinish = json['datefinish'];
    period_of_copun = json['period_of_copun'];
    amount = json['amount'];
    admin_id = json['admin_id'];
    postprice = json['postprice'] ?? 0.0;
    state = json['state'];
    type = json['type'];
    code_owner = json['code_owner'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    if (json['pivot'] != null) {
      debugPrint('pivot pivot not null');
      pivot = Pivot.fromJson(json['pivot']);
    }
  }

  Coupon(this.code_owner);

  Map<String, dynamic> PromotoJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code_owner'] = code_owner;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['datefinish'] = datefinish;
    data['period_of_copun'] = period_of_copun;
    data['amount'] = amount;
    data['admin_id'] = admin_id;
    data['state'] = state;
    data['type'] = type;
    data['code_owner'] = code_owner;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['pivot'] = pivot.toJson();

    return data;
  }
}
