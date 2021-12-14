import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/appdata/consts.dart';
import '/services/router.dart';
import '/ui/home/orders/user_orders.dart';
import '/ui/ui_components.dart';
import '/models/app_user.dart';
import '/models/neighbour_model.dart';
import '/models/order_model.dart';
import '/services/firebase_db.dart';
import '/ui/home/orders/order_tile.dart';

class HomeServices extends StatefulWidget {
  const HomeServices({Key? key}) : super(key: key);

  @override
  _HomeServicesState createState() => _HomeServicesState();
}

class _HomeServicesState extends State<HomeServices> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _neighbourOrdersStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _yourOrdersStream;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _neighbourOrdersStream = OrdersDatabase.getAllOrders(AppUser.uid);
    _yourOrdersStream = OrdersDatabase.getUserOrders(AppUser.uid);
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        _isLoaded ? _neighbourOrders() : const LoadingIndicator(),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            _isLoaded
                ? UserOrders(
                    stream: _yourOrdersStream,
                    author: Neighbour.fromJson(AppUser.toJson()),
                  )
                : const LoadingIndicator(),
            Positioned(
              bottom: 15,
              right: 15,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, addOrderRoute);
                  },
                  child: const Icon(
                    Icons.add,
                    size: 35,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _neighbourOrders() {
    return StreamBuilder(
      stream: _neighbourOrdersStream,
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasData) {
          return snapshot.data!.docs.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var orderDoc = snapshot.data!.docs.elementAt(index);
                    Map<String, dynamic> orderJson = orderDoc.data();
                    Order order = Order.fromJson(orderJson);

                    return StreamBuilder(
                      stream: UsersDatabase.getUser(order.authorId),
                      builder: (
                        context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot,
                      ) {
                        if (snapshot.hasData) {
                          var doc = snapshot.data!.docs.first;
                          Map<String, dynamic> json = doc.data();
                          Neighbour author = Neighbour.fromJson(json);

                          return OrderTile(order: order, author: author);
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                )
              : const MissingText(text: 'Нет предложений');
        } else {
          return Container();
        }
      },
    );
  }
}
