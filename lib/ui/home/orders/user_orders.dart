import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/ui/ui_components.dart';
import '/models/app_user.dart';
import '/models/neighbour_model.dart';
import '/models/order_model.dart';
import '/ui/home/orders/order_tile.dart';

class UserOrders extends StatelessWidget {
  const UserOrders({
    required this.stream,
    this.shrinkWrap = false,
    this.missingWidget,
    Key? key,
  }) : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final bool shrinkWrap;
  final Widget? missingWidget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasData) {
          return snapshot.data!.docs.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: shrinkWrap,
                  physics:
                      shrinkWrap ? const NeverScrollableScrollPhysics() : null,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs.elementAt(index);
                    Map<String, dynamic> json = doc.data();
                    Order order = Order.fromJson(json);
                    Neighbour author = Neighbour.fromJson(AppUser.toJson());

                    return OrderTile(order: order, author: author);
                  },
                )
              : missingWidget == null
                  ? const MissingText(text: 'Не предоставляете услуг')
                  : missingWidget!;
        } else {
          return Container();
        }
      },
    );
  }
}
