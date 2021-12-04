import 'package:flutter/material.dart';
import 'package:home_business/appdata/funcs.dart';

import '/appdata/consts.dart';
import '/ui/auth/address_setting.dart';
import '/ui/auth/phone_verification.dart';
import '/ui/auth/user_setting.dart';
import '/widgets/appbar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: getPadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomAppBar(leading: true),
            ),
            SizedBox(
              height: getScaffoldSize(context) - 40,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                children: const [
                  PhoneInfo(),
                  AddressInfo(),
                  UserInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
