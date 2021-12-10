import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message({
    required this.content,
    required this.senderId,
    required this.uid,
    required this.timeSend,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
      senderId: json['senderId'],
      uid: json['uid'],
      timeSend: json['timeSend'],
    );
  }

  String content, senderId, uid;
  Timestamp timeSend;

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'senderId': senderId,
      'uid': uid,
      'timeSend': timeSend,
    };
  }
}
