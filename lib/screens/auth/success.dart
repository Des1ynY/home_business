import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/appdata/appdata.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Get.offNamedUntil(homeRoute, (route) => false),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/phone_green.png',
              height: 300,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Регистрация завершена!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Нажмите, чтобы продолжить',
              style: TextStyle(
                color: CustomTheme.hintTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
