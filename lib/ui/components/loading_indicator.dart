import 'package:flutter/material.dart';

import '/appdata/theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: CustomTheme.primaryColor,
        backgroundColor: CustomTheme.backgroundColor,
      ),
    );
  }
}
