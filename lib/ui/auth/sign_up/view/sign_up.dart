import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '/ui/components/custom_button.dart';
import '/models/app_user.dart';
import '/services/firebase_auth.dart';
import '/services/firebase_db.dart';
import '/appdata/appdata.dart';

part 'address_setting.dart';
part 'phone_verification.dart';
part 'user_setting.dart';

final PageController loginPageController = PageController();
int loginCurrentPage = 0;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: getSafeAreaPadding(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                    AddressSettings(),
                    UserSettings(),
                    PhoneVerification(),
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
        color: pos == loginCurrentPage
            ? CustomTheme.primaryColor
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

  @override
  void dispose() {
    loginCurrentPage = 0;
    super.dispose();
  }
}
