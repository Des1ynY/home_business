import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/models/chat_model.dart';
import '/models/neighbour_model.dart';
import '/ui/home/people/neighbour_profile.dart';
import '/appdata/consts.dart';
import '/ui/home/chat/message_tile.dart';

class Chat extends StatefulWidget {
  const Chat({
    required this.chatInfo,
    required this.neighbour,
    Key? key,
  }) : super(key: key);

  final Chatroom chatInfo;
  final Neighbour neighbour;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
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
                backgroundImage: const AssetImage('assets/default_ava.png'),
                foregroundImage: AssetImage(widget.neighbour.imageUrl),
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
            child: SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return index % 2 == 0
                      ? MessageTile(
                          message: 'Привет',
                          timeSend: Timestamp.now(),
                        )
                      : MessageTile(
                          message:
                              'Ну и пойду, ну и посплю, ну и очень то мне хочется, ну и да',
                          timeSend: Timestamp.now(),
                          isYours: true,
                        );
                },
              ),
            ),
          ),
          const _MessageField(),
        ],
      ),
    );
  }
}

class _MessageField extends StatefulWidget {
  const _MessageField({Key? key}) : super(key: key);

  @override
  __MessageFieldState createState() => __MessageFieldState();
}

class __MessageFieldState extends State<_MessageField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              keyboardType: TextInputType.text,
              controller: _controller,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: GestureDetector(
              onTap: () {
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
}
