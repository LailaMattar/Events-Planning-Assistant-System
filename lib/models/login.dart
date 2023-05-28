import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/cupertino.dart';

class Login {
  late String email;
  late String name;
  late String profile_thumbnail;
  late String password;
  late int id;
  late int forbiddin;
  late int usecopun;
  late int beneficiary;
  late String token;
  late String gendre;
  late String error;
  late String type = 'null';
  late String fcm;
  late String email_verified_at;
  late String created_at;
  late String updated_at;
  late int max_number_of_person = 0;

  Login({required this.password, required this.email, required this.fcm});

  Login.fromJson(Map<String, dynamic> json) {
    print('dddd');
    id = json['id'];
    usecopun = json['usecopun']??0;
    error = json['error'] ?? " ";
    print('1');
    beneficiary = json['beneficiary']??0;
    print('2');
    forbiddin = json['forbiddin']??0;
    print('3');
    updated_at = json['updated_at'] ?? '';
    print('4');
    created_at = json['created_at'] ?? '';
    print('5');
    fcm = json['fcm'] ?? '';
    print('6');
    gendre = json['gendre'] ?? '';
    profile_thumbnail = json['profile_thumbnail'] ?? '';
    name = json['name'] ?? '';
    email_verified_at = json['email_verified_at'] ?? '';
    if (json['type'] == null) {
      debugPrint('test type');
      json['type'] = ' ';
    } else {
      type = json['type'];
    }
    if(json['max_number_of_person'] == null){
      json['max_number_of_person']=0;
      debugPrint("null hall");
    }else{
      max_number_of_person = json['max_number_of_person'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['fcm'] = theFcm;
    return data;
  }
}
