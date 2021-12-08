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
              const Divider(color: darkGrey, indent: 20, endIndent: 20),
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
    );
  }

  Widget _getServicesData(BuildContext context) {
    List<Widget> orders = [
      OrderTile(
        worker: widget.name,
        imageUrl: widget.imageUrl,
        title: 'Селфи на фоне Земли',
        description:
            'За относительно небольшую плату сделаю селфи на фоне Земли из иллюминатора МКС.',
        price: '50000 - 100000',
        tags: 'Фото Космос',
        orderId: '3',
      ),
      OrderTile(
        worker: widget.name,
        imageUrl: widget.imageUrl,
        title: 'Похохочем',
        description: 'За подробностями в лс.',
        tags: 'Культура Общение Юмор',
        orderId: '2',
      ),
      OrderTile(
        worker: widget.name,
        imageUrl: widget.imageUrl,
        title: 'Мобильное приложение на Flutter под Android',
        description:
            'Сделаю мобильное приложение на Flutter. Изучаю Dart примерно полгода, умею делать интерфейсы почти любой сложности, работаю с базой данных Firebase.',
        price: 'от 5000',
        tags: 'Mobile Flutter Android iOS Firebase UI UX',
        orderId: '4',
      )
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 3),
          child: Text(
            'Услуги',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        ListView.builder(
          itemCount: orders.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return orders.elementAt(index);
          },
        )
      ],
    );
  }
}
