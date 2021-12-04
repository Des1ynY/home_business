import 'package:flutter/material.dart';

class Chatrooms extends StatefulWidget {
  const Chatrooms({Key? key}) : super(key: key);

  @override
  _ChatroomsState createState() => _ChatroomsState();
}

class _ChatroomsState extends State<Chatrooms> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text('Чаты'),
        ),
      ],
    );
  }
}
