import 'package:event_planning/components/message_widget.dart';
import 'package:event_planning/models/message.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';

class MessagesWidget extends StatelessWidget {
  final String idUser;
  final List<Message> messages ;

   MessagesWidget({
    required this.idUser,
     required this.messages,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  messages.isEmpty
                  ? buildText('Say Hi..')
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        debugPrint("test state message : "+message.state.toString());
                        debugPrint("bool : "+(message.state == state).toString());
                        return MessageWidget(
                          message: message,
                          isMe: message.state == state,
                        );
                      },
                    );




  }

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24),
    ),
  );
}