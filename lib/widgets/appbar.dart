import 'package:flutter/material.dart';

import '/appdata/consts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.leading,
    Key? key,
  }) : super(key: key);

  final bool leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leading
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: RawMaterialButton(
                    onPressed: () => Navigator.pop(context),
                    elevation: 0,
                    child: const Icon(
                      Icons.arrow_back,
                      color: textColor,
                      size: 30,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
