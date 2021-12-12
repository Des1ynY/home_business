import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSettings {
  static initDatabase() async {
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: false);
  }
}

class UsersDatabase {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection('users');

  static checkUser(String uid) async {
    DocumentSnapshot doc = await _ref.doc(uid).get();

    return doc.exists;
  }

  static getUser(String uid) {
    return _ref.where('uid', isEqualTo: uid).snapshots();
  }

  static updateUser(String uid, Map<String, dynamic> json) async {
    await _ref.doc(uid).update(json);
  }

  static setUser(String uid, Map<String, String> json) async {
    await _ref.doc(uid).set(json, SetOptions(merge: true));
  }

  static getAllUsers(String uid) {
    return _ref
        .where('uid', isNotEqualTo: uid)
        .orderBy('uid')
        .orderBy('name')
        .snapshots();
  }
}

class ChatsDatabase {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection('chats');

  static getChats(String uid) {
    return _ref
        .where('users', arrayContains: uid)
        .orderBy('users')
        .orderBy('timeSend', descending: true)
        .snapshots();
  }

  static checkChat(String uid) async {
    DocumentSnapshot doc = await _ref.doc(uid).get();

    return doc.exists;
  }

  static createChat(String uid, Map<String, dynamic> chatInfo) async {
    await _ref.doc(uid).set(chatInfo);
  }

  static deleteChat(String uid) async {
    await _ref.doc(uid).delete();
  }

  static getMessages(String chatId) {
    return _ref
        .doc(chatId)
        .collection('chat')
        .orderBy('timeSend', descending: true)
        .snapshots();
  }

  static addMessage(String chatId, Map<String, dynamic> messageData) async {
    await _ref
        .doc(chatId)
        .collection('chat')
        .doc(messageData['uid'])
        .set(messageData);
  }

  static updateChatLastMessage(
    String chatId,
    Map<String, dynamic> messageData,
  ) async {
    await _ref.doc(chatId).update(messageData);
  }
}

class OrdersDatabase {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection('orders');

  static getAllOrders(String uid) {
    return _ref
        .where('authorId', isNotEqualTo: uid)
        .orderBy('authorId')
        .orderBy('creationDate', descending: true)
        .snapshots();
  }

  static getUserOrders(String uid) {
    return _ref
        .where('authorId', isEqualTo: uid)
        .orderBy('creationDate', descending: true)
        .snapshots();
  }

  static createOrder(String uid, Map<String, dynamic> orderInfo) async {
    await _ref.doc(uid).set(orderInfo, SetOptions(merge: true));
  }

  static updateOrder(String uid, Map<String, dynamic> orderInfo) async {
    await _ref.doc(uid).update(orderInfo);
  }

  static deleteOrder(String uid) async {
    await _ref.doc(uid).delete();
  }
}
