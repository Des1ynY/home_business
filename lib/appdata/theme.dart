import 'package:flutter/material.dart';

class CustomTheme {
  static const Color primaryColor = Color(0xFF37ACA2);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color shadowColor = Colors.white70;
  static const Color textColor = Color(0xFF313131);
  static const Color hintTextColor = Color(0xFFC6C6C6);
  static const Color borderColor = Color(0xFFEDEDED);
  static const Color darkGrey = Color(0x66707070);
  static const Color red = Color(0xFFF96060);
  static const Color blue = Color(0xFF6074F9);

  static ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    fontFamily: 'AvenirNextCyr',
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      headline2: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      subtitle1: TextStyle(
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
        color: backgroundColor,
      ),
    ),
    buttonTheme: ButtonThemeData(
      height: 48,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
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
      backgroundColor: backgroundColor,
      foregroundColor: primaryColor,
      shadowColor: shadowColor,
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
