import 'package:event_planning/blocs/messages_bloc.dart';
import 'package:event_planning/components/messages_widget.dart';
import 'package:event_planning/components/new_message_widget.dart';
import 'package:event_planning/components/profile_header_widget.dart';
import 'package:event_planning/models/message.dart';
import 'package:event_planning/models/user.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';

import 'error_page.dart';
import 'loading_page.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late MessagesBloc _bloc;
  late User user2;

  @override
  void initState() {
    _bloc = MessagesBloc();
    debugPrint("test tyyyype : "+widget.user.type + " "+widget.user.id.toString());
    if(state == 8){
      if(widget.user.type == "Venues"){
        user2 = User.messages(id: widget.user.id, type: "user", who: 2,state: state);
      }else{
        user2 = User.messages(id: widget.user.id, type: "user", who: 1,state: state);
      }
    }else if(state == 9){
      user2 = User.messages(id: widget.user.id, type: "vendor", who: 1,state: state);
    }else{
      user2 = User.messages(id: widget.user.id, type: "venues", who: 1,state: state);
    }

  }

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: pink,
    body: SafeArea(
      child: StreamBuilder<ApiResponse<User>>(
          stream: _bloc.theStream,
          builder: (context,snapshot){
            if (snapshot.hasError) {
              debugPrint('error');
            }else if(snapshot.hasData){
              switch(snapshot.data!.status){
                case Status.LOADING:
                  debugPrint('loading chat');
                  return const LoadingPage();
                case Status.COMPLETED:
                  debugPrint('complete chat');
                  return CompletePsge(user: snapshot.data!.data,user2: widget.user);
                case Status.ERROR:
                  debugPrint('error chats');
                  WidgetsBinding.instance!.addPostFrameCallback((_){
                    var snackBar = const SnackBar(content: Text('Error'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                  return ErrorPage(onRetryPressed: () => _bloc.getBox(widget.user.id,user2),);
              }
            }
            // debugPrint('outside $snapshot');
            _bloc.getBox(widget.user.id,user2);
            return Container();
          }
      ),
    ),
  );
}


class CompletePsge extends StatefulWidget {
  final User user;
  final User user2;
  const CompletePsge({Key? key,required this.user,required this.user2}) : super(key: key);

  @override
  _CompletePsgeState createState() => _CompletePsgeState(user:user);
}

class _CompletePsgeState extends State<CompletePsge> {
  User user;
  late List<Message> messageLaila;

  @override
  void initState() {
    messageLaila = [];
    for(int i = user.messages.length-1 ; i >= 0 ; i --){
      messageLaila.add(user.messages[i]);
    }
  }

  _CompletePsgeState({required this.user});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileHeaderWidget(name: widget.user2.name),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: MessagesWidget(idUser: widget.user2.id.toString(), messages: messageLaila,),
          ),
        ),
        NewMessageWidget(idUser: widget.user2.id)
      ],
    );
  }
}
