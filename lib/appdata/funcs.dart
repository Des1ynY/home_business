import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '/models/app_user.dart';
import '/models/neighbour_model.dart';
import '/services/firebase_db.dart';
import '/screens/home/chat/chat.dart';

const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(20);
const EdgeInsetsGeometry paddingWithAppbar =
    EdgeInsets.only(right: 20, left: 20, bottom: 40);

double getScaffoldHeight(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;
}

double getScaffoldHeightWithoutAppbar(BuildContext context) {
  return getScaffoldHeight(context) - 56;
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

String getTimeSend(Timestamp timestamp) {
  DateTime time = timestamp.toDate();

  return sprintf('%d:%02d', [time.hour, time.minute]);
}

String getChatId(String userId, String neighbourId) {
  int comparationResult = userId.compareTo(neighbourId);

  return comparationResult <= 0
      ? '$userId.$neighbourId'
      : '$neighbourId.$userId';
}

String getUID({int len = 28}) {
  var random = Random();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

enterChatroom(BuildContext context, Neighbour neighbour) async {
  String chatId = getChatId(
    AppUser.uid,
    neighbour.uid,
  );

  if (!await ChatsDatabase.checkChat(chatId)) {
    await ChatsDatabase.createChat(
      chatId,
      {
        'uid': chatId,
        'users': [AppUser.uid, neighbour.uid],
      },
    );
  }
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Chat(chatId: chatId, neighbour: neighbour),
    ),
  );
}
