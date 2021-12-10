import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/appdata/consts.dart';
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
  late Stream<QuerySnapshot<Map<String, dynamic>>> neighbourOrdersStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> yourOrdersStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> usersStream;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    neighbourOrdersStream = OrdersDatabase.getAllOrders(AppUser.uid);
    yourOrdersStream = OrdersDatabase.getUserOrders(AppUser.uid);
    usersStream = UsersDatabase.getAllUsers(AppUser.uid);
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        _isLoaded
            ? _neighbourOrders()
            : const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  backgroundColor: Colors.white,
                ),
              ),
        _isLoaded
            ? _yourOrders()
            : const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  backgroundColor: Colors.white,
                ),
              )
      ],
    );
  }

  Widget _neighbourOrders() {
    return StreamBuilder(
      stream: neighbourOrdersStream,
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> orderSnapshot,
      ) {
        if (orderSnapshot.hasData) {
          return orderSnapshot.data!.docs.isNotEmpty
              ? ListView.builder(
                  itemCount: orderSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = orderSnapshot.data!.docs.elementAt(index);
                    Map<String, dynamic> orderJson = doc.data();
                    Order order = Order.fromJson(orderJson);

                    return StreamBuilder(
                      stream: usersStream,
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              userSnapshot) {
                        var doc = userSnapshot.data?.docs.firstWhere(
                            (element) => element['uid'] == order.authorId);
                        Map<String, dynamic> userJson = doc?.data() ?? {};
                        Neighbour neighbour = Neighbour.fromJson(userJson);

                        return OrderTile(order: order, author: neighbour);
                      },
                    );
                  },
                )
              : const Center(
                  child: Text(
                    'Предложений нет',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: darkGrey,
                    ),
                  ),
                );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _yourOrders() {
    return StreamBuilder(
      stream: yourOrdersStream,
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasData) {
          return snapshot.data!.docs.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs.elementAt(index);
                    Map<String, dynamic> json = doc.data();
                    Order order = Order.fromJson(json);
                    Neighbour author = Neighbour.fromJson(AppUser.toJson());

                    return OrderTile(order: order, author: author);
                  },
                )
              : const Center(
                  child: Text(
                    'Не предоставляете услуг',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: darkGrey,
                    ),
                  ),
                );
        } else {
          return Container();
        }
      },
    );
  }
}
