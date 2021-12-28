import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.label,
    this.action,
    Key? key,
  }) : super(key: key);

  final String label;
  final Function? action;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => action!(),
      elevation: 0,
      highlightElevation: 0,
      minWidth: Get.width,
      color: Get.theme.primaryColor,
      child: Text(
        label,
        style: Get.textTheme.button,
      ),
    );
  }
}
