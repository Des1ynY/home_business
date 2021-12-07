import 'package:flutter/material.dart';

class OrderTile extends StatefulWidget {
  const OrderTile({Key? key}) : super(key: key);

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: const Card(
        color: Colors.white,
        elevation: 5,
      ),
    );
  }
}
