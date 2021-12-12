import 'package:cloud_firestore/cloud_firestore.dart';

class Chatroom {
  Chatroom({
    required this.content,
    required this.senderId,
    required this.timeSend,
    required this.users,
    required this.uid,
  });

  factory Chatroom.fromJson(Map<String, dynamic> json) {
    return Chatroom(
      content: json['content'],
      senderId: json['senderId'],
      timeSend: json['timeSend'],
      users: json['users'],
      uid: json['uid'],
    );
  }

  String content, senderId;
  Timestamp timeSend;
  List<dynamic> users;
  String uid;

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'senderId': senderId,
      'timeSend': timeSend,
      'users': users,
      'uid': uid,
    };
  }
}
