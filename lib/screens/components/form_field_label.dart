import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormFieldLabel extends StatelessWidget {
  const FormFieldLabel({
    required this.label,
    Key? key,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Get.textTheme.headline2,
    );
  }
}
