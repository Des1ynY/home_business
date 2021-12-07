import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

double getScaffoldHeight(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;
}

EdgeInsetsGeometry getSafeAreaPadding(BuildContext context) {
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

bool isDigit(String? number) {
  if (number != null) {
    for (int i = 0; i < number.length; i++) {
      try {
        int.parse(number[i]);
        continue;
      } on FormatException {
        return false;
      }
    }
    return true;
  }
  return false;
}

String getTimeSend(DateTime time) {
  return sprintf('%d:%02d', [time.hour, time.minute]);
}

String getHeroTag({int? seed = 999999}) {
  Random rnd = Random(seed);
  int firstId = rnd.nextInt(9999999);
  int secondId = rnd.nextInt(9999999);

  return '$firstId.hero_tag.$secondId';
}
