import 'package:event_planning/utils/utils_fun.dart';


class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  late int id;
  late String message;
  late int who;
  late int state;

  Message({
    required this.state,
    required this.message,
    required this.who,
  });

  Message.fromJson(Map<String,dynamic> json){
    id = json['id'];
    message = json['message'];
    who = json['who'];
    this.state = json['state'];
  }

  Message.fromJsonSend(){}

  toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['who'] = who;
    data['message'] = message;
    return data;
  }

  // static Message fromJson(Map<String, dynamic> json) => Message(
  //   idUser: json['idUser'],
  //   urlAvatar: json['urlAvatar'],
  //   username: json['username'],
  //   message: json['message'],
  //   createdAt: toDateTime(json['createdAt']),
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   'idUser': idUser,
  //   'urlAvatar': urlAvatar,
  //   'username': username,
  //   'message': message,
  //   'createdAt': fromDateTimeToJson(createdAt),
  // };
}