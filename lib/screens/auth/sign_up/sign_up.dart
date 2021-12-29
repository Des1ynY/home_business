import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/services/validators.dart';
import '/controllers/auth_controller.dart';
import '/screens/components/loading_indicator.dart';
import '/screens/components/custom_text_button.dart';
import '/screens/components/form_field.dart';
import '/screens/components/form_field_label.dart';
import '/screens/components/custom_button.dart';
import '/appdata/appdata.dart';

part 'address_setting.dart';
part 'phone_verification.dart';
part 'user_setting.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthController _authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                _getIndicator(0),
                _getIndicator(1),
                _getIndicator(2),
              ],
            ),
            Container(
              width: Get.width,
              height: getScaffoldHeightWithoutAppbar(context) - 8,
              child: PageView(
                controller: _authController.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  AddressSetting(),
                  UserSettings(),
                  PhoneVerification(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIndicator(int pos) {
    return Obx(
      () => Container(
        height: 8,
        width: (Get.width - 60) / 3,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: _authController.currentPage.value == pos
              ? CustomTheme.primaryColor
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authController.signUpDispose();
    super.dispose();
  }
}
