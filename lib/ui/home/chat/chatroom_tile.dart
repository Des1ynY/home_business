import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/ui/home/chat/chat.dart';
import '/appdata/consts.dart';

class ChatroomTile extends StatefulWidget {
  const ChatroomTile({
    required this.message,
    required this.speaker,
    required this.avatar,
    required this.time,
    Key? key,
  }) : super(key: key);

  final String message, speaker, avatar, time;

  @override
  _ChatroomTileState createState() => _ChatroomTileState();
}

class _ChatroomTileState extends State<ChatroomTile> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            flex: 1,
            spacing: 0,
            backgroundColor: const Color(0xFFF96060),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить',
          ),
        ],
      ),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chat(
                name: widget.speaker,
                imageUrl: widget.avatar,
              ),
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
                  backgroundImage: const AssetImage('assets/default_ava.png'),
                  foregroundImage: AssetImage(widget.avatar),
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
                              widget.speaker,
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
                          widget.time,
                          style: const TextStyle(
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
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              widget.message,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
