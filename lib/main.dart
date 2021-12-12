import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'appdata/theme.dart';
import 'services/router.dart';
import 'services/firebase_auth.dart';
import 'services/auth_checker.dart';
import 'services/shared_prefs.dart';
import 'models/app_user.dart';
import 'services/firebase_db.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DatabaseSettings.initDatabase();
  await LocalDataStorage.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  AppUser.setUser(LocalDataStorage.getUserData(AppUser.keys()));

  runApp(const HomeBusiness());
}

class HomeBusiness extends StatelessWidget {
  const HomeBusiness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => Auth.authStateChanges(),
      initialData: null,
      child: MaterialApp(
        builder: (context, child) => ScrollConfiguration(
          behavior: NoGlowScrollEffect(),
          child: child ?? Container(),
        ),
        theme: CustomTheme.mainTheme,
        onGenerateRoute: generateRoute,
        title: 'Home Business',
        home: const AuthChecker(),
      ),
    );
  }
}
