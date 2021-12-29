import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get userStream => _auth.authStateChanges();

  Future<void> verifyPhone({
    required String number,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<UserCredential> signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    return await _auth.signInWithCredential(phoneAuthCredential);
  }

  PhoneAuthCredential getPhoneAuthCredential(
    String verificationId,
    String otp,
  ) {
    return PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
