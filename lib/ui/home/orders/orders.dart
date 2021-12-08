import 'package:flutter/material.dart';

import '/ui/home/orders/order_tile.dart';

class HomeServices extends StatefulWidget {
  const HomeServices({Key? key}) : super(key: key);

  @override
  _HomeServicesState createState() => _HomeServicesState();
}

class _HomeServicesState extends State<HomeServices> {
  static const List<Widget> _orders = <Widget>[
    OrderTile(
      worker: 'Космонавт Бывший',
      imageUrl:
          'https://www.meme-arsenal.com/memes/4558599e1a8d184795a2ccbb0606ed22.jpg',
      title: 'Я хлебп',
      orderId: '1',
    ),
    OrderTile(
      worker: 'Бывшая Космонавта',
      imageUrl:
          'https://i.pinimg.com/originals/63/c5/dd/63c5ddd6176dd503ca9e45e231fd1be8.jpg',
      title: 'Похохочем',
      description: 'За подробностями в лс.',
      tags: 'Культура Общение Юмор',
      orderId: '2',
    ),
    OrderTile(
      worker: 'Работник МКС',
      imageUrl: 'https://s00.yaplakal.com/pics/pics_original/3/0/1/7033103.jpg',
      title: 'Селфи на фоне Земли',
      description:
          'За относительно небольшую плату сделаю селфи на фоне Земли из иллюминатора МКС.',
      price: '50000 - 100000',
      tags: 'Фото Космос',
      orderId: '3',
    ),
    OrderTile(
      worker: 'Иван Пиреев',
      imageUrl:
          'https://i.pinimg.com/originals/3f/ef/9f/3fef9f35f46e15fb86605cdab22fbf2e.jpg',
      title: 'Мобильное приложение на Flutter под Android',
      description:
          'Сделаю мобильное приложение на Flutter. Изучаю Dart примерно полгода, умею делать интерфейсы почти любой сложности, работаю с базой данных Firebase.',
      price: 'от 5000',
      tags: 'Mobile Flutter Android iOS Firebase UI UX',
      orderId: '4',
    ),
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
