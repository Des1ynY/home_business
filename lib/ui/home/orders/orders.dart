import 'package:flutter/material.dart';

import '/ui/home/orders/order_tile.dart';

class HomeServices extends StatefulWidget {
  const HomeServices({Key? key}) : super(key: key);

  @override
  _HomeServicesState createState() => _HomeServicesState();
}

class _HomeServicesState extends State<HomeServices> {
  static const List<Widget> _orders = <Widget>[
    OrderTile(),
    OrderTile(),
    OrderTile(),
    OrderTile(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _orders.elementAt(index % _orders.length);
      },
    );
  }
}
