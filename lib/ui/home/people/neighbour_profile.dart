import 'package:flutter/material.dart';

import '/ui/home/orders/order_tile.dart';
import '/appdata/consts.dart';

class NeighbourProfile extends StatefulWidget {
  const NeighbourProfile({
    required this.name,
    required this.bio,
    required this.imageUrl,
    required this.apartment,
    this.heroTag = '',
    Key? key,
  }) : super(key: key);

  final String imageUrl, name, apartment, bio, heroTag;

  @override
  _NeighbourProfileState createState() => _NeighbourProfileState();
}

class _NeighbourProfileState extends State<NeighbourProfile> {
  bool _isFavourite = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getProfileData(context),
              const Divider(
                color: borderColor,
                indent: 20,
                endIndent: 20,
                height: 40,
              ),
              _getServicesData(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getProfileData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Hero(
            tag: widget.heroTag,
            child: CircleAvatar(
              radius: 100,
              backgroundImage: const AssetImage('assets/default_ava.png'),
              foregroundImage: NetworkImage(widget.imageUrl),
            ),
          ),
        ),
        Text(
          widget.name,
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          'кв. ${widget.apartment}',
          style: const TextStyle(color: hintTextColor),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: TextField(
            decoration: InputDecoration(
              label: const Text(
                'О себе',
                style: TextStyle(
                  color: hintTextColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: borderColor),
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
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: buttonHeight,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    border: const Border.fromBorderSide(
                      BorderSide(color: borderColor),
                    ),
                    borderRadius: BorderRadius.circular(buttonBorderRadius),
                  ),
                  child: RawMaterialButton(
                    onPressed: () {},
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
                    BorderSide(color: borderColor),
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
                          color: borderColor,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getServicesData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Услуги',
          style: Theme.of(context).textTheme.headline2,
        ),
        ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const OrderTile();
          },
        )
      ],
    );
  }
}
