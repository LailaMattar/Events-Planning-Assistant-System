import 'package:event_planning/models/user.dart';

class Users{
  late List<User> users;

  Users.fromJson(Map<String,dynamic> json){
    users = [];
    if(json['box '].length == 0){
      users = [];
    }else{
      users = List<User>.from(json['box '].map((model) => User.fromJson(model)));
      }
    }

}