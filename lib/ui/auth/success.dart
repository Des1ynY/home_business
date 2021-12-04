import 'package:flutter/material.dart';

import '/appdata/consts.dart';
import '/services/router.dart';
import '/appdata/funcs.dart';

class SuccessLogin extends StatefulWidget {
  const SuccessLogin({Key? key}) : super(key: key);

  @override
  _SuccessLoginState createState() => _SuccessLoginState();
}

class _SuccessLoginState extends State<SuccessLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: getScaffoldSize(context),
        width: MediaQuery.of(context).size.width,
        padding: getPadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, residentsRoute, (route) => false),
              child: Container(
                height: 300,
                margin: const EdgeInsets.only(bottom: 40),
                child: Image.asset('assets/phone_green.png'),
              ),
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
              'Нажмите на изображение, чтобы продолжить',
              style: TextStyle(
                color: hintTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
