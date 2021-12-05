import 'package:flutter/material.dart';

import '/appdata/consts.dart';
import '/appdata/funcs.dart';
import '/ui/auth/address_setting.dart';
import '/ui/auth/phone_verification.dart';
import '/ui/auth/user_setting.dart';
import '/widgets/appbar.dart';

final PageController loginPageController = PageController();
int loginCurrentPage = 0;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: getSafeAreaPadding(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomAppBar(leading: true),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getIndicator(0),
                  _getIndicator(1),
                  _getIndicator(2),
                ],
              ),
              SizedBox(
                height: getScaffoldHeight(context) - 60,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                  controller: loginPageController,
                  onPageChanged: (_) => setState(() {
                    loginCurrentPage = loginCurrentPage;
                  }),
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    PhoneVerification(),
                    AddressSettings(),
                    UserSettings(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getIndicator(int pos) {
    return Container(
      height: 8,
      width: (MediaQuery.of(context).size.width - 60) / 3,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: pos == loginCurrentPage ? primaryColor : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
