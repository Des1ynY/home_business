import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '/appdata/appdata.dart';

part 'welcome_cover.dart';

class Welcome extends StatelessWidget {
  Welcome({Key? key}) : super(key: key);

  final List<Widget> _covers = [
    WelcomeCover(
      title: 'Соседи могут быть полезны',
      subtitle: 'Находите работников среди своих соседей!',
      imagePath: 'assets/img/welcome_1.png',
      color: CustomTheme.primaryColor,
      index: 0,
    ),
    WelcomeCover(
      title: 'Предлагайте услуги сами',
      subtitle:
          'Хорошо готовите кофе или умеете чинить кран? Предложите помощь соседям!',
      imagePath: 'assets/img/welcome_2.png',
      color: CustomTheme.blue,
      index: 1,
    ),
    WelcomeCover(
      title: 'Знакомьтесь и заводите друзей',
      subtitle: 'Узнавайте соседей ближе, может кто-то станет вашим другом?',
      imagePath: 'assets/img/welcome_3.png',
      color: CustomTheme.red,
      index: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          LiquidSwipe(
            pages: _covers,
          ),
          Container(
            height: 270,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () => Get.toNamed(signUpRoute),
                  elevation: 0,
                  highlightElevation: 0,
                  color: CustomTheme.backgroundColor,
                  minWidth: Get.width,
                  child: Text(
                    'Войти в приложение',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: CustomTheme.textColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(adminRoute),
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(
                        'Я администратор',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
