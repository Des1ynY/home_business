import 'package:flutter/material.dart';

import '/appdata/consts.dart';

class CustomTheme {
  static ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    fontFamily: 'AvenirNextCyr',
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headline2: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headline3: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: textColor,
      ),
      subtitle2: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: hintTextColor,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      button: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: hintTextColor,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
    ),
    disabledColor: hintTextColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: primaryColor,
      shadowColor: Colors.white70,
      elevation: 2,
    ),
  );
}

class NoGlowScrollEffect extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
