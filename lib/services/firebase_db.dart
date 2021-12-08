import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/app_user.dart';

class UsersDatabase {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection('users');

  static checkUser(String uid) async {
    var doc = await _ref.doc(uid).get();

    return doc.exists;
  }

  static setUser() async {
    var user = AppUser();

    await _ref.doc(user.uid).set(user.toJson(), SetOptions(merge: true));
  }
}
