import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/appdata/consts.dart';
import '/appdata/funcs.dart';
import '/widgets/appbar.dart';

class AdminWelcome extends StatelessWidget {
  const AdminWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _contactEmail = 'Smetanin.Ivan@urfu.me';

    return Scaffold(
      body: Container(
        height: getScaffoldHeight(context),
        padding: getSafeAreaPadding(context),
        child: Container(
          padding: paddingWithAppbar,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const CustomAppBar(leading: true),
                  Image.asset(
                    'assets/MacBook_green.png',
                    height: 300,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'Хотите подключить ваш дом к системе?',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Мы рассмотрим вашу заявку и предоставим доступ к программе!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        const ClipboardData(text: _contactEmail),
                      ).then(
                        (_) => Fluttertoast.showToast(
                          msg: 'Адрес скопирован',
                          backgroundColor: Colors.black.withOpacity(0.7),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        _contactEmail,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Напишите нам',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: hintTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
