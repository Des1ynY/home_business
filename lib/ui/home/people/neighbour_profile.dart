import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/appdata/funcs.dart';
import '/services/firebase_db.dart';
import '/ui/home/orders/user_orders.dart';
import '/ui/ui_components.dart';
import '/models/neighbour_model.dart';
import '/appdata/consts.dart';

class NeighbourProfile extends StatefulWidget {
  const NeighbourProfile({
    required this.neighbour,
    Key? key,
  }) : super(key: key);

  final Neighbour neighbour;

  @override
  _NeighbourProfileState createState() => _NeighbourProfileState();
}

class _NeighbourProfileState extends State<NeighbourProfile> {
  final TextEditingController _controller = TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> _neighbourOrdersStream;
  bool _isFavourite = false, _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.neighbour.bio;
    _neighbourOrdersStream = OrdersDatabase.getUserOrders(widget.neighbour.uid);
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getProfileData(context),
            const Divider(color: darkGrey, indent: 40, endIndent: 40),
            _getServicesData(context),
          ],
        ),
      ),
    );
  }

  Widget _getProfileData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Hero(
              tag: widget.neighbour.uid,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: const AssetImage('assets/default_ava.png'),
                foregroundImage: widget.neighbour.imageUrl == 'unknown'
                    ? null
                    : NetworkImage(widget.neighbour.imageUrl),
              ),
            ),
          ),
          Text(
            "${widget.neighbour.name} ${widget.neighbour.surname}",
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            'кв. ${widget.neighbour.apartment}',
            style: const TextStyle(color: darkGrey),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                label: const Text(
                  'О себе',
                  style: TextStyle(
                    color: darkGrey,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: darkGrey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              minLines: 1,
              maxLines: 5,
              controller: _controller,
              readOnly: true,
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: buttonHeight,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: const Border.fromBorderSide(
                        BorderSide(color: darkGrey),
                      ),
                      borderRadius: BorderRadius.circular(buttonBorderRadius),
                    ),
                    child: RawMaterialButton(
                      onPressed: () => enterChatroom(context, widget.neighbour),
                      elevation: 0,
                      child: const Text(
                        'Написать',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: buttonHeight,
                  width: buttonHeight,
                  decoration: BoxDecoration(
                    border: const Border.fromBorderSide(
                      BorderSide(color: darkGrey),
                    ),
                    borderRadius: BorderRadius.circular(buttonBorderRadius),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isFavourite = !_isFavourite;
                      });
                    },
                    child: _isFavourite
                        ? const Icon(
                            Icons.star,
                            size: 35,
                            color: Color(0xFFFFD037),
                          )
                        : const Icon(
                            Icons.star_border,
                            size: 35,
                            color: darkGrey,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getServicesData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Услуги',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        _isLoaded
            ? UserOrders(
                stream: _neighbourOrdersStream,
                author: widget.neighbour,
                shrinkWrap: true,
                missingWidget: const SizedBox(
                  height: 200,
                  child: MissingText(
                    text: 'Не предоставляет услуг',
                  ),
                ),
              )
            : const LoadingIndicator(),
      ],
    );
  }
}
