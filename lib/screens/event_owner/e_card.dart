import 'package:flutter/material.dart';

class E_Card extends StatefulWidget {
  const E_Card({Key? key}) : super(key: key);

  @override
  _E_CardState createState() => _E_CardState();
}

class _E_CardState extends State<E_Card> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Invitation card'),
        ),
        body: Container(
          child: Column(
            children: [
              Text('engagment'),
              Text('marriage'),
              Text('gradute'),
              Text('baby '),
              Text('party'),
            ],
          ),
        ));
  }
}
