import 'package:flutter/material.dart';

import 'neighbour_tile.dart';

class Residents extends StatefulWidget {
  const Residents({Key? key}) : super(key: key);

  @override
  _ResidentsState createState() => _ResidentsState();
}

class _ResidentsState extends State<Residents> {
  static const List<Widget> _neigbours = <Widget>[
    NeigbourProfileTile(
      name: 'Космонавт Бывший',
      bio:
          'Бывший космонавт, работал на МКС с 2014 по 2025 годы. Люблю читать и летать.',
      apartment: '123',
      imageUrl:
          'https://www.meme-arsenal.com/memes/4558599e1a8d184795a2ccbb0606ed22.jpg',
    ),
    NeigbourProfileTile(
      name: 'Бывшая космонавта',
      bio:
          'Бывшая космонавта, работала на СКМ с 2025 по 2014 годы. Не люблю читать и летать.',
      apartment: '321',
      imageUrl:
          'https://i.pinimg.com/originals/63/c5/dd/63c5ddd6176dd503ca9e45e231fd1be8.jpg',
    ),
    NeigbourProfileTile(
      name: 'Работник МКС',
      bio: 'Эти двое сверху заколебали весь дом... На самом деле я Игорь.',
      apartment: '666',
      imageUrl: 'https://s00.yaplakal.com/pics/pics_original/3/0/1/7033103.jpg',
    ),
    NeigbourProfileTile(
      name: 'Иван Иванов',
      bio: 'Я тут один нормальный...',
      apartment: '1',
      imageUrl:
          'https://i.pinimg.com/originals/3f/ef/9f/3fef9f35f46e15fb86605cdab22fbf2e.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _neigbours.length,
      itemBuilder: (context, index) {
        return _neigbours.elementAt(index % _neigbours.length);
      },
    );
  }
}
