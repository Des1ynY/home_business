import 'package:flutter/material.dart';

import '/appdata/theme.dart';

class TagTile extends StatelessWidget {
  const TagTile({
    required this.tag,
    Key? key,
  }) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(
        top: 3,
        bottom: 5,
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border.fromBorderSide(
          BorderSide(color: CustomTheme.hintTextColor),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: const TextStyle(color: CustomTheme.hintTextColor),
          ),
        ],
      ),
    );
  }
}
