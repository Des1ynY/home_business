import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/auth/welcome.dart';
import '/ui/home/residents.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<User?>();

    if (currentUser != null) {
      return const Residents();
    } else {
      return const Welcome();
    }
  }
}
