import 'package:flutter/material.dart';

import '/appdata/consts.dart';

class OrderTile extends StatefulWidget {
  const OrderTile({
    required this.worker,
    required this.imageUrl,
    required this.title,
    required this.orderId,
    this.description = '',
    this.price = '',
    this.tags = '',
    Key? key,
  }) : super(key: key);

  final String imageUrl, worker;
  final String title, description;
  final String price, tags;
  final String orderId;

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    List<String> tagList = widget.price.isNotEmpty ? [widget.price] : [];
    if (widget.tags.isNotEmpty) tagList.addAll(widget.tags.split(' '));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        minHeight: 50,
        maxHeight: 200,
      ),
      child: Card(
        color: Colors.white,
        elevation: 10,
        shadowColor: Colors.white70,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage:
                                  const AssetImage('assets/default_ava.png'),
                              foregroundImage: NetworkImage(widget.imageUrl),
                            ),
                          ),
                          Text(widget.worker),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                tagList.isNotEmpty
                    ? Container(
                        height: 30,
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ListView.builder(
                          itemCount: tagList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return widget.price.isEmpty
                                ? _getTagTile(tagList.elementAt(index))
                                : _getTagTile(
                                    tagList.elementAt(index),
                                    isPriceTile: index == 0,
                                  );
                          },
                        ),
                      )
                    : Container(),
                Flexible(
                  child: Text(
                    widget.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTagTile(String tag, {bool isPriceTile = false}) {
    return isPriceTile
        ? Container(
            height: 30,
            padding: const EdgeInsets.only(
              top: 3,
              bottom: 5,
              left: 7,
              right: 7,
            ),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.3),
              border: const Border.fromBorderSide(
                BorderSide(color: primaryColor),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                '${widget.price} руб.',
                style: const TextStyle(color: primaryColor),
              ),
            ),
          )
        : Container(
            height: 30,
            padding: const EdgeInsets.only(
              top: 3,
              bottom: 5,
              left: 7,
              right: 7,
            ),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: borderColor,
              border: const Border.fromBorderSide(
                BorderSide(color: hintTextColor),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(child: Text(tag)),
          );
  }
}
