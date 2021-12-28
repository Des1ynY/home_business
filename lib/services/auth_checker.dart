import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/app_user.dart';
import '/services/firebase_db.dart';
import '/ui/auth/welcome.dart';
import '/ui/home/screens.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<User?>();

    if (currentUser != null) {
      return StreamBuilder(
        stream: UsersDatabase.getUser(currentUser.uid),
        builder: (
          context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.hasData) {
            var doc = snapshot.data!.docs.first;
            Map<String, dynamic> json = doc.data();
            AppUser.setUser(json);

            return const HomeScreens();
          } else {
            return Container();
          }
        },
      );
    } else {
      return const Welcome();
    }
  }
}
