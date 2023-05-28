import 'package:event_planning/blocs/box_bloc.dart';
import 'package:event_planning/components/chat_body_widget.dart';
import 'package:event_planning/models/user.dart';
import 'package:event_planning/models/users.dart';
import 'package:event_planning/networking/api_response.dart';
import 'package:event_planning/networking/firebase_api.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/material.dart';

import 'error_page.dart';
import 'loading_page.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  List<User> users = [];
  late BoxBloc _bloc;
  late User user;

  @override
  void initState() {
    users.add(User(id: 1, name: "Laila",type:" "));
    _bloc = BoxBloc();
    user = User.box(state: state);
    debugPrint("state : "+ state.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: SafeArea(
        child: StreamBuilder<ApiResponse<Users>>(
            stream: _bloc.theStream,
            builder: (context,snapshot){
              if (snapshot.hasError) {
                debugPrint('error');
              }else if(snapshot.hasData){
                switch(snapshot.data!.status){
                  case Status.LOADING:
                    debugPrint('loading chats');
                    return const LoadingPage();
                  case Status.COMPLETED:
                    debugPrint('complete chats');
                    return CompletePage(users: snapshot.data!.data.users,);
                  case Status.ERROR:
                    debugPrint('error chats');
                    WidgetsBinding.instance!.addPostFrameCallback((_){
                      var snackBar = const SnackBar(content: Text('Error'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                    return ErrorPage(onRetryPressed: () => _bloc.getBox(user),);
                }
              }
              // debugPrint('outside $snapshot');
              _bloc.getBox(user);
              return Container();
            }
        ),
      ),
    );
  }

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
}


class CompletePage extends StatefulWidget {
  final List<User> users;
  const CompletePage({Key? key,required this.users}) : super(key: key);

  @override
  _CompletePageState createState() => _CompletePageState(users: this.users);
}

class _CompletePageState extends State<CompletePage> {
  List<User> users;
  _CompletePageState({required this.users});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ChatHeaderWidget(users: users),
        ChatBodyWidget(users: users)
      ],
    );
  }
}
