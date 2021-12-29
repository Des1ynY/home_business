import 'package:flutter/material.dart';

import '/appdata/theme.dart';

class CustomFormField extends TextFormField {
  CustomFormField(
      {required String hintText,
      required TextEditingController controller,
      FocusNode? focusNode,
      keyboardType = TextInputType.text,
      textCapitalization = TextCapitalization.words,
      String? Function(String?)? validator,
      void Function(String)? action,
      bool? enabled})
      : super(
          decoration: InputDecoration(hintText: hintText),
          enabled: enabled,
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          cursorColor: CustomTheme.primaryColor,
          validator: validator,
          onFieldSubmitted: action,
        );
}
