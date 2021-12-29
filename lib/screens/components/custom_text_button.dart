import 'package:flutter/material.dart';

import '/appdata/theme.dart';

class CustomTextButton extends GestureDetector {
  CustomTextButton({required String text, required void Function()? action})
      : super(
            onTap: action,
            child: SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: CustomTheme.textColor,
                  ),
                ),
              ),
            ));
}
