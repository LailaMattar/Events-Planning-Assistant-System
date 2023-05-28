import 'package:event_planning/models/message.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class User {
  late int id;
  late String name;
  late String image;
  late String type = " ";
  late int state;
  late List<Message> messages;
  late int who;

  User.book({required this.id,required this.name,required this.image,required this.type});
  User({required this.id,required this.name,required this.type});
  User.messages({required this.id,required this.type,required this.who,required this.state});
  User.box({required this.state});

  User.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    if(json['type'] == null){
      type = " ";
    }else{
      type = json['type'];
    }
    image = json['profile_thumbnail'];
  }

  toJsonBox(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    return data;
  }

  toJsonMessages(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['who'] = who;
    return data;
  }

  User.fromJsonMessages(List<dynamic> json){
    if(json.length == 0){
      messages = [];
    }else{
      messages = [];
      debugPrint("messages length : "+json.length.toString());
      for(int i = 0 ; i < json.length ; i ++){
        messages.add(Message.fromJson(json[i]));
      }
    }
  }
  // User({
  //   required this.idUser,
  //   required this.name,
  //   required this.urlAvatar,
  //   required this.lastMessageTime,
  // });

  // User copyWith({
  //   required String idUser,
  //   required String name,
  //   required String urlAvatar,
  //   required DateTime lastMessageTime,
  // }) =>
  //     User(
  //       idUser: idUser ,
  //       name: name ,
  //       urlAvatar: urlAvatar ,
  //       lastMessageTime: lastMessageTime ,
  //     );
  //
  // static User fromJson(Map<String, dynamic> json) => User(
  //   idUser: json['idUser'],
  //   name: json['name'],
  //   urlAvatar: json['urlAvatar'],
  //   lastMessageTime: toDateTime(json['lastMessageTime']),
  // );

  // Map<String, dynamic> toJson() => {
  //   'idUser': idUser,
  //   'name': name,
  //   'urlAvatar': urlAvatar,
  //   'lastMessageTime': fromDateTimeToJson(lastMessageTime),
  // };
}