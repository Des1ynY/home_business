import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'appdata/routes.dart';
import 'appdata/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(HomeBusiness());
}

class HomeBusiness extends GetMaterialApp {
  HomeBusiness({Key? key})
      : super(
          title: 'Home Business',
          theme: CustomTheme.mainTheme,
          getPages: getxRoutes,
          initialRoute: welcomeRoute,
        );
}
