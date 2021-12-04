import 'package:flutter/material.dart';

import '/appdata/consts.dart';
import '/appdata/funcs.dart';

class CustomLayer extends StatelessWidget {
  const CustomLayer({
    this.child,
    Key? key,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: getScaffoldSize(context),
        padding: getPadding(context),
        child: Padding(
          padding: paddingWithAppbar,
          child: child,
        ),
      ),
    );
  }
}
