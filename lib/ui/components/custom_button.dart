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
      hoverElevation: 0,
      child: Text(
        label,
        style: Get.textTheme.button,
      ),
    );
  }
}
