import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '/appdata/consts.dart';
import '/services/router.dart';
import 'welcome_cover.dart';
import '/appdata/funcs.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: getSafeAreaPadding(context),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            LiquidSwipe(
              pages: const [
                WelcomeCover(
                  header: 'Соседи могут быть полезны',
                  text: 'Находите работников среди своих соседей!',
                  imagePath: 'assets/welcome-1.png',
                  index: 0,
                  color: primaryColor,
                ),
                WelcomeCover(
                  header: 'Предлагайте услуги сами',
                  text:
                      'Хорошо готовите кофе или умеете чинить кран? Предложите помощь соседям!',
                  imagePath: 'assets/welcome-2.png',
                  index: 1,
                  color: Color(0xFF6074F9),
                ),
                WelcomeCover(
                  header: 'Знакомьтесь и заводите друзей',
                  text:
                      'Узнавайте соседей ближе, может кто-то станет вашим другом?',
                  imagePath: 'assets/welcome-3.png',
                  index: 2,
                  color: Color(0xFFF96060),
                ),
              ],
            ),
            SizedBox(
              height: 270,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: buttonHeight,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      bottom: 15,
                      right: 40,
                      left: 40,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(buttonBorderRadius),
                      color: Colors.white,
                    ),
                    child: RawMaterialButton(
                      onPressed: () => Navigator.pushNamed(context, loginRoute),
                      elevation: 0,
                      child: const Text(
                        'Войти в приложение',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, adminRoute),
                    child: SizedBox(
                      height: 30,
                      child: Text(
                        'Я администратор',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
