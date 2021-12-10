import 'package:flutter/material.dart';

import '/services/shared_prefs.dart';
import '/services/firebase_auth.dart';

class AppUserSettings extends StatefulWidget {
  const AppUserSettings({Key? key}) : super(key: key);

  @override
  _AppUserSettingsState createState() => _AppUserSettingsState();
}

class _AppUserSettingsState extends State<AppUserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RawMaterialButton(
                onPressed: () async {
                  await Auth.signOut();
                  await LocalDataStorage.deleteUserData();
                  Navigator.pop(context);
                },
                elevation: 0,
                child: Text(
                  'Выйти из аккаунта',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
