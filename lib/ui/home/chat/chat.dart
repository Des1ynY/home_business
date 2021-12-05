import 'package:flutter/material.dart';

import '/appdata/consts.dart';
import '/ui/home/chat/message_tile.dart';

class Chat extends StatefulWidget {
  const Chat({
    required this.name,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String imageUrl, name;
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 20,
              backgroundImage: const AssetImage('assets/default_ava.png'),
              foregroundImage: AssetImage(widget.imageUrl),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: textColor,
                ),
              ),
            ),
          ],
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
                          timeSend: DateTime(2000, 3, 4, 17, 30),
                        )
                      : MessageTile(
                          message:
                              'Ну и пойду, ну и посплю, ну и очень то мне хочется, ну и да',
                          timeSend: DateTime(2000, 3, 4, 6, 5),
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
        bottom: MediaQuery.of(context).padding.bottom + 7,
        top: 7,
        right: 20,
        left: 20,
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
