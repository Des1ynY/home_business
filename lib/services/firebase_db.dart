import 'package:cloud_firestore/cloud_firestore.dart';

class UsersDatabase {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection('users');

  static checkUser(String uid) async {
    DocumentSnapshot doc = await _ref.doc(uid).get();

    return doc.exists;
  }

  static setUser(String uid, Map<String, String> json) async {
    await _ref.doc(uid).set(json, SetOptions(merge: true));
  }

  static getUser(String uid) async {
    return await _ref.doc(uid).get();
  }
}
