import 'package:flutter/material.dart';

import '/services/firebase_db.dart';
import '/appdata/funcs.dart';
import '/models/app_user.dart';
import '/models/chat_model.dart';
import '/models/neighbour_model.dart';
import '/appdata/consts.dart';

class ChatroomTile extends StatefulWidget {
  const ChatroomTile({
    required this.chatInfo,
    required this.neighbour,
    Key? key,
  }) : super(key: key);

  final Chatroom chatInfo;
  final Neighbour neighbour;

  @override
  _ChatroomTileState createState() => _ChatroomTileState();
}

class _ChatroomTileState extends State<ChatroomTile> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        enterChatroom(context, widget.neighbour);
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: RawMaterialButton(
                  onPressed: () async {
                    await ChatsDatabase.deleteChat(widget.chatInfo.uid);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Удалить чат',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      elevation: 0,
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: const AssetImage('assets/img/default_ava.png'),
                foregroundImage: widget.neighbour.imageUrl == 'unknown'
                    ? null
                    : NetworkImage(widget.neighbour.imageUrl),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: SizedBox(
                          child: Text(
                            '${widget.neighbour.name} ${widget.neighbour.surname}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        getTimeSend(widget.chatInfo.timeSend),
                        style: const TextStyle(
                          fontSize: 12,
                          color: hintTextColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, top: 5),
                          child: widget.chatInfo.senderId == AppUser.uid
                              ? RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: 'Вы: ',
                                    style: const TextStyle(
                                      fontFamily: 'AvenirNextCyr',
                                      color: primaryColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: widget.chatInfo.content,
                                        style: const TextStyle(
                                          fontFamily: 'AvenirNextCyr',
                                          color: Color(0xFF707070),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Text(
                                  widget.chatInfo.content,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xFF707070),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
