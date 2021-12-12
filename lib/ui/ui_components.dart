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

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

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
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              height: 50,
              child: Image.asset(
                'assets/back_button.png',
                width: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: primaryColor,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class MissingText extends StatelessWidget {
  const MissingText({required this.text, Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: darkGrey,
        ),
      ),
    );
  }
}
