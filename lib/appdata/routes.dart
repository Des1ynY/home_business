import 'package:get/get.dart';

import '/screens/auth/welcome/admin.dart';
import '/screens/auth/sign_in.dart';
import '/screens/auth/sign_up/sign_up.dart';
import '/screens/auth/success.dart';
import '/screens/auth/welcome/welcome.dart';
import '/screens/home/orders/add_order.dart';
import '/screens/home/profile/profile_settings.dart';
import '/screens/home/screens.dart';

const String welcomeRoute = '/welcome';
const String adminRoute = '/admin';
const String signUpRoute = '/signUp';
const String signInRoute = '/signIn';
const String successRoute = '/success';
const String homeRoute = '/homescreen';
const String addOrderRoute = '/addOrder';
const String settingsRoute = '/settings';

List<GetPage> getxRoutes = [
  GetPage(name: welcomeRoute, page: () => Welcome()),
  GetPage(name: adminRoute, page: () => AdminPage()),
  GetPage(name: signUpRoute, page: () => SignUp()),
  GetPage(name: signInRoute, page: () => SignIn()),
  GetPage(name: successRoute, page: () => SuccessPage()),
  GetPage(name: homeRoute, page: () => HomeScreens()),
  GetPage(name: addOrderRoute, page: () => AddOrder()),
  GetPage(name: settingsRoute, page: () => ProfileSettings()),
];
