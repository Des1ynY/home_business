import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/ui/ui_components.dart';
import '/models/app_user.dart';
import '/models/chat_model.dart';
import '/models/neighbour_model.dart';
import '/services/firebase_db.dart';
import '/ui/home/chat/chatroom_tile.dart';

class Chatrooms extends StatefulWidget {
  const Chatrooms({Key? key}) : super(key: key);

  @override
  _ChatroomsState createState() => _ChatroomsState();
}

class _ChatroomsState extends State<Chatrooms> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _chatroomsStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _chatroomsStream = ChatsDatabase.getChats(AppUser.uid);
    _usersStream = UsersDatabase.getAllUsers(AppUser.uid);
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded ? _chatrooms() : const LoadingIndicator();
  }

  Widget _chatrooms() {
    return StreamBuilder(
      stream: _chatroomsStream,
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> chatSnapshot,
      ) {
        if (chatSnapshot.hasData) {
          return chatSnapshot.data!.docs.isNotEmpty
              ? ListView.builder(
                  itemCount: chatSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = chatSnapshot.data!.docs.elementAt(index);
                    Map<String, dynamic> chatJson = doc.data();
                    Chatroom chat = Chatroom.fromJson(chatJson);

                    return StreamBuilder(
                      stream: _usersStream,
                      builder: (
                        context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            userSnapshot,
                      ) {
                        if (userSnapshot.hasData) {
                          var doc = userSnapshot.data?.docs.firstWhere(
                              (element) =>
                                  element['uid'] ==
                                  chat.users.firstWhere(
                                      (element) => element != AppUser.uid));
                          Map<String, dynamic> userJson = doc?.data() ?? {};
                          Neighbour neigbour = Neighbour.fromJson(userJson);

                          return ChatroomTile(
                              chatInfo: chat, neighbour: neigbour);
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                )
              : const MissingText(text: 'Нет активных чатов');
        } else {
          return Container();
        }
      },
    );
  }
}
