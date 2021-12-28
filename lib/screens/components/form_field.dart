import 'package:flutter/material.dart';

import '/appdata/theme.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.words,
    this.validator,
    this.action,
    Key? key,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final void Function(String)? action;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      cursorColor: CustomTheme.primaryColor,
      validator: validator,
      onFieldSubmitted: action,
    );
  }
}
