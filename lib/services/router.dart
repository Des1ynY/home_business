import 'package:flutter/material.dart';

import '/ui/auth/admin.dart';
import '/ui/home/residents.dart';
import '/ui/auth/phone_verification.dart';
import '/ui/auth/welcome.dart';

// page routes
const String welcomeRoute = '/welcome';
const String adminRoute = '/admin';
const String loginRoute = '/login';
const String residentsRoute = '/residents';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case welcomeRoute:
      return MaterialPageRoute(builder: (context) => const Welcome());
    case adminRoute:
      return MaterialPageRoute(builder: (context) => const AdminWelcome());
    case loginRoute:
      return MaterialPageRoute(builder: (context) => const PhoneInfo());
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
