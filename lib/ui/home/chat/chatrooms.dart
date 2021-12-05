import 'package:flutter/material.dart';

import '/ui/home/chat/chatroom_tile.dart';

class Chatrooms extends StatefulWidget {
  const Chatrooms({Key? key}) : super(key: key);

  @override
  _ChatroomsState createState() => _ChatroomsState();
}

class _ChatroomsState extends State<Chatrooms> {
  static const List<Widget> _chatrooms = <Widget>[
    ChatroomTile(
        message: 'Мы армяне, с нами русские, с ними Бог.',
        speaker: 'Армянин Главный',
        avatar: 'assets/ava_1.png',
        time: '17:09'),
    ChatroomTile(
        message: 'Я Бог, со мной русские, с ними армяне.',
        speaker: 'Бог Верховный',
        avatar: 'assets/ava_2.png',
        time: '11:11'),
    ChatroomTile(
        message: 'Мы русские, с нами Бог, с нами армяне.',
        speaker: 'Русский Заглавный',
        avatar: 'assets/ava_3.png',
        time: '16:20'),
    ChatroomTile(
        message: 'We\'re americans, we want liberty!',
        speaker: 'America The Greatest',
        avatar: 'assets/ava_0.png',
        time: '22:22'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return _chatrooms.elementAt(index % _chatrooms.length);
    });
  }
}
