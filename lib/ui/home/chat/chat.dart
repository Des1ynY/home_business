import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/appdata/funcs.dart';
import '/models/app_user.dart';
import '/models/message_model.dart';
import '/ui/home/chat/message_tile.dart';
import '/services/firebase_db.dart';
import '/ui/ui_components.dart';
import '/models/neighbour_model.dart';
import '/ui/home/people/neighbour_profile.dart';
import '/appdata/consts.dart';

class Chat extends StatefulWidget {
  const Chat({
    required this.chatId,
    required this.neighbour,
    Key? key,
  }) : super(key: key);

  final String chatId;
  final Neighbour neighbour;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _controller = TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> _messagesStream;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _messagesStream = ChatsDatabase.getMessages(widget.chatId);
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: RawMaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NeighbourProfile(neighbour: widget.neighbour),
              ),
            );
          },
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 20,
                backgroundImage: const AssetImage('assets/img/default_ava.png'),
                foregroundImage: widget.neighbour.imageUrl == 'unknown'
                    ? null
                    : NetworkImage(widget.neighbour.imageUrl),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  '${widget.neighbour.name} ${widget.neighbour.surname}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: _isLoaded ? _messages() : const LoadingIndicator(),
          ),
          _inputField(),
        ],
      ),
    );
  }

  Widget _messages() {
    return StreamBuilder(
      stream: _messagesStream,
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasData) {
          return snapshot.data!.docs.isNotEmpty
              ? ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs.elementAt(index);
                    Map<String, dynamic> json = doc.data();
                    Message message = Message.fromJson(json);

                    return MessageTile(message: message);
                  },
                )
              : const MissingText(text: 'Начните общение!');
        } else {
          return Container();
        }
      },
    );
  }

  Widget _inputField() {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 15,
        top: 7,
        right: 15,
        left: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Пиши...',
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: hintTextColor, width: 1.5),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: primaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
              ),
              style: const TextStyle(fontFamily: 'Roboto'),
              minLines: 1,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              controller: _controller,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: GestureDetector(
              onTap: () {
                _sendMessage();
                setState(() {
                  _controller.text = '';
                });
              },
              child: const Icon(
                Icons.send_rounded,
                size: 30,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _sendMessage() async {
    Message message = Message(
      content: _controller.text.trim(),
      senderId: AppUser.uid,
      uid: getUID(),
      timeSend: Timestamp.now(),
    );

    await ChatsDatabase.addMessage(widget.chatId, message.toJson());
    await ChatsDatabase.updateChatLastMessage(widget.chatId, message.toJson());
  }
}
