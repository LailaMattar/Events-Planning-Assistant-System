import 'package:event_planning/models/user.dart';
import 'package:event_planning/screens/chat_page.dart';
import 'package:event_planning/utils/utils_var.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<User> users;

  const ChatBodyWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      decoration:const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: buildChats(),
    ),
  );

  Widget buildChats() => ListView.builder(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      final user = users[index];

      return Container(
        height: 75,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatPage(user: user),
              ));
            },
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(apiUrl+"storage/UserPhoto/VendorProfile/"+user.image),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name),
                const SizedBox(height: 5,),
                Text(user.type)
              ],
            ),
          ),
        ),
      );
    },
    itemCount: users.length,
  );
}