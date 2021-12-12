import 'package:flutter/material.dart';

import '/services/firebase_db.dart';
import '/models/app_user.dart';
import '/appdata/funcs.dart';
import '/ui/ui_components.dart';
import '/appdata/consts.dart';
import '/models/neighbour_model.dart';
import '/models/order_model.dart';

class FullOrderTile extends StatefulWidget {
  const FullOrderTile({
    required this.order,
    required this.author,
    Key? key,
  }) : super(key: key);

  final Order order;
  final Neighbour author;

  @override
  _FullOrderTileState createState() => _FullOrderTileState();
}

class _FullOrderTileState extends State<FullOrderTile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Услуга'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: widget.order.uid,
                child: Text(
                  widget.order.title,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Text(
                widget.order.price,
                style: const TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30, top: 25),
                child: Flexible(
                  child: Text(
                    widget.order.description,
                    style: const TextStyle(fontSize: 18, height: 1.5),
                  ),
                ),
              ),
              widget.author.uid == AppUser.uid
                  ? _getButton(
                      'Удалить предложение',
                      red,
                      () async {
                        await OrdersDatabase.deleteOrder(widget.order.uid);
                        Navigator.pop(context);
                      },
                    )
                  : _getButton(
                      'Написать продавцу',
                      primaryColor,
                      () {
                        enterChatroom(context, widget.author);
                      },
                    ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 15),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: List<Widget>.generate(
                    widget.order.tags.length,
                    (index) => TagTile(
                      tag: widget.order.tags.elementAt(index),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Text(
                      'Автор:',
                      style: TextStyle(
                        fontSize: 16,
                        color: darkGrey,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 5,
                    ),
                    child: CircleAvatar(
                      radius: 17,
                      backgroundImage:
                          const AssetImage('assets/default_ava.png'),
                      foregroundImage: widget.author.imageUrl == 'unknown'
                          ? null
                          : NetworkImage(widget.author.imageUrl),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.author.uid == AppUser.uid
                          ? 'Вы'
                          : '${widget.author.name} ${widget.author.surname}',
                      style: const TextStyle(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getButton(String label, Color color, Function action) {
    return Container(
      height: buttonHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(buttonBorderRadius),
      ),
      child: RawMaterialButton(
        onPressed: () => action(),
        elevation: 0,
        child: Text(
          label,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
