import 'package:flutter/material.dart';

import '/appdata/consts.dart';

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
    return Container(
      height: buttonHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(buttonBorderRadius),
      ),
      child: RawMaterialButton(
        onPressed: () => action!(),
        elevation: 0,
        child: Text(
          label,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
