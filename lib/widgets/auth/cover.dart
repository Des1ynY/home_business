import 'package:flutter/material.dart';

class WelcomeCover extends StatelessWidget {
  const WelcomeCover({
    required this.header,
    required this.text,
    required this.imagePath,
    required this.index,
    required this.color,
    Key? key,
  }) : super(key: key);

  final int index;
  final Color? color;
  final String imagePath, header, text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 250,
            margin: const EdgeInsets.only(top: 40),
            child: Center(
              child: Image.asset(imagePath),
            ),
          ),
          Container(
            height: 130,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      header,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                  height: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getIndicator(0),
                      _getIndicator(1),
                      _getIndicator(2),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 270,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.elliptical(150, 20),
                topRight: Radius.elliptical(150, 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIndicator(int pos) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: index == pos ? Colors.black : const Color(0xFF979797),
      ),
    );
  }
}
