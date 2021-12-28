import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/appdata/routes.dart';
import '/appdata/theme.dart';
import '/appdata/funcs.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Get.offNamedUntil(homeRoute, (route) => false),
        child: Container(
          height: getScaffoldHeight(context),
          width: MediaQuery.of(context).size.width,
          padding: getSafeAreaPadding(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                margin: const EdgeInsets.only(bottom: 40),
                child: Image.asset('assets/img/phone_green.png'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Text(
                  'Регистрация завершена!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const Text(
                'Нажмите, чтобы продолжить',
                style: TextStyle(
                  color: CustomTheme.hintTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
