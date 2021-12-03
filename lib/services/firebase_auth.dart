import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<User?> authStateChanges() => _auth.authStateChanges();

  static verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function verificationFailed,
    required Function codeSent,
  }) async {
    try {
      await _auth.setLanguageCode('ru');
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 90),
        verificationCompleted: (phoneAuthCredential) async {
          verificationCompleted(phoneAuthCredential);
        },
        verificationFailed: verificationFailed(),
        codeSent: codeSent(),
        codeAutoRetrievalTimeout: (verificationID) async {
          log('Code auto retrieval timeout');
        },
      );
    } on FirebaseException catch (e) {
      log(e.message!);
    }
  }

  static signInWithPhoneAuthCredential(PhoneAuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
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
