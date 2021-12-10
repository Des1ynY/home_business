import 'package:flutter/material.dart';

import '/ui/auth/sign_in.dart';
import '../ui/home/profile/profile_settings.dart';
import '/ui/home/screens.dart';
import '/ui/auth/success.dart';
import '/ui/auth/admin.dart';
import '../ui/auth/sign_up.dart';
import '/ui/auth/welcome.dart';

// page routes
const String welcomeRoute = '/welcome';
const String adminRoute = '/admin';
const String signUpRoute = '/signUp';
const String signInRoute = '/signIn';
const String successRoute = '/success';
const String homescreenRoute = '/homescreen';
const String userSettingsRoute = '/settings';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case welcomeRoute:
      return MaterialPageRoute(builder: (context) => const Welcome());
    case adminRoute:
      return MaterialPageRoute(builder: (context) => const AdminWelcome());
    case signUpRoute:
      return MaterialPageRoute(builder: (context) => const SignUp());
    case signInRoute:
      return MaterialPageRoute(builder: (context) => const SignIn());
    case successRoute:
      return MaterialPageRoute(builder: (context) => const SuccessLogin());
    case homescreenRoute:
      return MaterialPageRoute(builder: (context) => const HomeScreens());
    case userSettingsRoute:
      return MaterialPageRoute(builder: (context) => const AppUserSettings());
    default:
      return MaterialPageRoute(builder: (context) => const ErrorPage());
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "404 Page not Found",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
