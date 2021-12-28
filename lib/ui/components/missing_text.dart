import 'package:flutter/material.dart';

import '/appdata/theme.dart';

class MissingText extends StatelessWidget {
  const MissingText({required this.text, Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: CustomTheme.darkGrey,
        ),
      ),
    );
  }
}
