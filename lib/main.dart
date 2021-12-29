import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controllers/network_controller.dart';
import 'controllers/auth_controller.dart';
import 'appdata/appdata.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(HomeBusiness());
}

class HomeBusiness extends StatelessWidget {
  HomeBusiness({Key? key}) : super(key: key);

  final NetworkController networkController = Get.put(NetworkController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Home Business',
      theme: CustomTheme.mainTheme,
      getPages: getxRoutes,
      initialRoute: authController.authChecker(authController.isLogged.value),
    );
  }
}
