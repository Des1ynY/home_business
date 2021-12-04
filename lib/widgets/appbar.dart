import 'package:flutter/material.dart';

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
              ? GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    width: 25,
                    child: Image.asset('assets/back_button.png'),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
