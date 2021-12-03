import 'package:flutter/material.dart';
import 'package:home_business/services/firebase_auth.dart';

class Residents extends StatefulWidget {
  const Residents({Key? key}) : super(key: key);

  @override
  _ResidentsState createState() => _ResidentsState();
}

class _ResidentsState extends State<Residents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Auth.signOut(),
          ),
        ],
      ),
    );
  }
}
