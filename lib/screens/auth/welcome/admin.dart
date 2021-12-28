import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/appdata/appdata.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  final _contactEmail = 'Smetanin.Ivan@urfu.me';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        height: getScaffoldHeight(context),
        padding: paddingWithAppbar,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/mac_green.png',
              height: 270,
            ),
            Spacer(),
            Text(
              'Хотите подключить ваш дом к системе?',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Мы рассмотрим вашу заявку и предоставим доступ к программе!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Clipboard.setData(
                    ClipboardData(text: _contactEmail),
                  ).then(
                    (_) => Fluttertoast.showToast(
                      msg: 'Скопировано!',
                      backgroundColor: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      _contactEmail,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: CustomTheme.primaryColor,
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
                    color: CustomTheme.hintTextColor,
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
