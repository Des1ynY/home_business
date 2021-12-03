import 'package:flutter/material.dart';

double getScaffoldSize(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;
}

EdgeInsetsGeometry getPadding(BuildContext context) {
  return EdgeInsets.only(
    top: MediaQuery.of(context).padding.top,
    bottom: MediaQuery.of(context).padding.bottom,
  );
}

bool isValidPhone(String? value) {
  if (value != null) {
    return RegExp(r'^((8|\+7)[\- ]?)?(\(?\d{3,4}\)?[\- ]?)?[\d\- ]{5,10}$')
        .hasMatch(value);
  }
  return false;
}

bool isValidEmail(String? value) {
  if (value != null) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
  return false;
}

bool isValidPass(String? value) {
  if (value != null) {
    return value.length >= 6 ? true : false;
  }
  return false;
}
