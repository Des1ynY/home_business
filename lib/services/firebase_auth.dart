import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static FirebaseAuth get auth => _auth;

  static Stream<User?> authStateChanges() => _auth.authStateChanges();

  static signInWithPhoneAuthCredential(PhoneAuthCredential credential) async {
    try {
      return await _auth.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      log(e.message!);
    }
  }

  static signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseException catch (e) {
      log(e.message!);
    }
  }
}
