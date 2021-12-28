import 'package:flutter/material.dart';

import '/screens/components/tag_tile.dart';
import '/appdata/theme.dart';
import '/services/firebase_db.dart';
import '/models/app_user.dart';
import '/appdata/funcs.dart';
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
        child: Padding(
          padding: defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.order.title,
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                widget.order.price,
                style: const TextStyle(
                  fontSize: 20,
                  color: CustomTheme.primaryColor,
                ),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30, top: 25),
                  child: Text(
                    widget.order.description,
                    style: const TextStyle(fontSize: 18, height: 1.5),
                  ),
                ),
              ),
              widget.author.uid == AppUser.uid
                  ? _getButton(
                      'Удалить предложение',
                      CustomTheme.red,
                      () async {
                        await OrdersDatabase.deleteOrder(widget.order.uid);
                        Navigator.pop(context);
                      },
                    )
                  : _getButton(
                      'Написать продавцу',
                      CustomTheme.primaryColor,
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
                        color: CustomTheme.darkGrey,
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
                          const AssetImage('assets/img/default_ava.png'),
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
    return MaterialButton(
      onPressed: () => action(),
      color: color,
      elevation: 0,
      hoverElevation: 0,
      child: Text(
        label,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
