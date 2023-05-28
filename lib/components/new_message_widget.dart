import 'package:event_planning/models/message.dart';
import 'package:event_planning/repositories/messages_repo.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';
class NewMessageWidget extends StatefulWidget {
  final int idUser;

  const NewMessageWidget({
    required this.idUser,
    Key? key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    MessagesRepo messagesRepo = MessagesRepo();
    late Message message2;
    if(state == 8){
      message2 = Message(who: 1,message: _controller.text , state: state);
    }else{
      message2 = Message(who: 1,message: _controller.text,state: state);
    }
    await messagesRepo.sendMessage(widget.idUser, message2);
    Navigator.pop(context);
    //put send api
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
    padding: EdgeInsets.all(8),
    child: Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              labelText: 'Type your message',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0),
                gapPadding: 10,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onChanged: (value) => setState(() {
              message = value;
            }),
          ),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: message.trim().isEmpty ? null : sendMessage,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Icon(Icons.send, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}