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

String? isValidPhoneNumber(String? phone) {
  if (phone == null || phone.isEmpty) return 'Укажите номер';
  if (phone.length < 11) return 'Неправильно набран номер';

  var pattern =
      r'(^((8|\+7)[\- ]?)?\(?\d{3,5}\)?[\- ]?\d{1}[\- ]?\d{1}[\- ]?\d{1}[\- ]?\d{1}[\- ]?\d{1}(([\- ]?\d{1})?[\- ]?\d{1})?$)';

  return RegExp(pattern).hasMatch(phone) ? null : 'Неправильно набран номер';
}

String makePhoneValid(String phone) {
  var result = StringBuffer(phone.startsWith('+') ? '+' : '+7');

  for (var i = 1; i < phone.length; i++) {
    try {
      int.parse(phone[i]);
      result.write(phone[i]);
    } on FormatException {
      continue;
    }
  }

  return result.toString();
}

bool isValidEmail(String? value) {
  if (value != null) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
  return false;
}

bool isDigit(String? number) {
  try {
    int.parse(number!);
    return true;
  } on FormatException {
    return false;
  }
}
