import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/ui/ui_components.dart';
import '/models/app_user.dart';
import '/models/neighbour_model.dart';
import '/services/firebase_db.dart';
import 'neighbour_tile.dart';

class Residents extends StatefulWidget {
  const Residents({Key? key}) : super(key: key);

  @override
  _ResidentsState createState() => _ResidentsState();
}

class _ResidentsState extends State<Residents> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _usersStream = UsersDatabase.getAllUsers(AppUser.uid);
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded ? _neighbourhoods() : const LoadingIndicator();
  }

  Widget _neighbourhoods() {
    return StreamBuilder(
      stream: _usersStream,
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  var doc = snapshot.data?.docs.elementAt(index);
                  Map<String, dynamic> json = doc?.data() ?? {};
                  Neighbour neighbour = Neighbour.fromJson(json);

                  return NeigbourProfileTile(neighbour: neighbour);
                },
              )
            : Container();
      },
    );
  }
}
