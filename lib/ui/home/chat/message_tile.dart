import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/models/app_user.dart';
import '/models/message_model.dart';
import '/appdata/consts.dart';
import '/appdata/funcs.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    required this.message,
    Key? key,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    bool isYours = message.senderId == AppUser.uid;

    return Container(
      margin: EdgeInsets.only(
        top: 10,
        left: isYours ? 60 : 15,
        right: isYours ? 15 : 60,
      ),
      child: Column(
        crossAxisAlignment:
            isYours ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isYours ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(
                      ClipboardData(text: message.content),
                    ).then(
                      (_) => Fluttertoast.showToast(
                        msg: 'Скопировано',
                        backgroundColor: Colors.black.withOpacity(0.7),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      gradient: isYours
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                primaryColor,
                                primaryColor.withOpacity(0.8),
                                const Color(0xFF63C6E0),
                              ],
                            )
                          : const LinearGradient(colors: [
                              Color(0xFFEFEFEF),
                              Color(0xFFEFEFEF),
                            ]),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25),
                        topRight: const Radius.circular(25),
                        bottomLeft: isYours
                            ? const Radius.circular(25)
                            : const Radius.circular(0),
                        bottomRight: isYours
                            ? const Radius.circular(0)
                            : const Radius.circular(25),
                      ),
                    ),
                    child: Text(
                      message.content,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Roboto',
                        color: isYours ? Colors.white : textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
                isYours ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 3),
                child: Text(
                  getTimeSend(message.timeSend),
                  style: const TextStyle(
                    fontSize: 12,
                    color: hintTextColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
