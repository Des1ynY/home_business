import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/auth/welcome.dart';
import '/ui/home/screens.dart';
import '/models/app_user.dart';
import '/services/shared_prefs.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<User?>();

    if (currentUser != null) {
      var user = AppUser();
      var data = LocalDataStorage.getUserData(user.getFields());
      user.setUser(data);

      return const ScreensProvider();
    } else {
      return const Welcome();
    }
  }
}
