import 'dart:convert';

import 'package:event_planning/models/message.dart';
import 'package:event_planning/models/user.dart';
import 'package:event_planning/networking/api_base_helper.dart';
import 'package:flutter/cupertino.dart';

class MessagesRepo{
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<User> getMessages(int personId,User user)async{
    final response = await _helper.post('api/get_message/$personId',jsonEncode(user.toJsonMessages()));
    debugPrint('the get messages body is $response');
    return User.fromJsonMessages(response);
  }

  Future<Message> sendMessage(int personId,Message message)async{
    final response = await _helper.post('api/chat/$personId',jsonEncode(message.toJson()));
    debugPrint('the get messages body is $response');
    return Message.fromJsonSend();
  }
}