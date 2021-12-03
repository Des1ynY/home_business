import 'package:flutter/material.dart';

import '/ui/home/residents.dart';
import '/ui/auth/restore_pass.dart';
import '/ui/auth/sign_in.dart';
import '/ui/auth/sign_up.dart';
import '/ui/auth/welcome.dart';

// page routes
const String welcomeRoute = '/welcome';
const String signInRoute = '/signIn';
const String signUpRoute = '/signUp';
const String restoreRoute = '/restore';
const String residentsRoute = '/residents';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case welcomeRoute:
      return MaterialPageRoute(builder: (context) => const Welcome());
    case signInRoute:
      return MaterialPageRoute(builder: (context) => const SignIn());
    case signUpRoute:
      return MaterialPageRoute(builder: (context) => const SignUp());
    case restoreRoute:
      return MaterialPageRoute(builder: (context) => const RestorePass());
    case residentsRoute:
      return MaterialPageRoute(builder: (context) => const Residents());
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
