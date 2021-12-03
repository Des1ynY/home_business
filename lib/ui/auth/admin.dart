import 'package:flutter/material.dart';
import 'package:home_business/appdata/consts.dart';
import 'package:home_business/appdata/funcs.dart';

class AdminWelcome extends StatelessWidget {
  const AdminWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: getScaffoldSize(context),
        padding: getPadding(context),
        child: Container(
          padding: paddingWithAppbar,
          child: Column(),
        ),
      ),
    );
  }
}
