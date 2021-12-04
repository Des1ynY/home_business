import 'package:flutter/material.dart';

class Residents extends StatefulWidget {
  const Residents({Key? key}) : super(key: key);

  @override
  _ResidentsState createState() => _ResidentsState();
}

class _ResidentsState extends State<Residents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text('Жители'),
        ),
      ],
    );
  }
}
