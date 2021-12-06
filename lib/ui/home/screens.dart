import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '/appdata/consts.dart';
import '/ui/home/chat/chatrooms.dart';
import '/ui/home/orders/orders.dart';
import '/ui/home/people/neighbourhoods.dart';
import '/ui/home/profile/profile.dart';

class ScreensProvider extends StatefulWidget {
  const ScreensProvider({Key? key}) : super(key: key);

  @override
  _ScreensProviderState createState() => _ScreensProviderState();
}

class _ScreensProviderState extends State<ScreensProvider> {
  int _currentIndex = 3;
  static const List<Widget> _screens = <Widget>[
    Residents(),
    HomeServices(),
    Chatrooms(),
    AppUserProfile(),
  ];
  static const List<Widget> _appbarTitles = <Widget>[
    Text('Соседи'),
    Text('Услуги'),
    Text('Чаты'),
    Text('Профиль'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_currentIndex),
      appBar: AppBar(
        title: _appbarTitles.elementAt(_currentIndex),
        centerTitle: true,
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        height: MediaQuery.of(context).padding.bottom + 60,
        elevation: 20,
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.indicator,
        snakeViewColor: primaryColor,
        currentIndex: _currentIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: hintTextColor,
        showSelectedLabels: true,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'Соседи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_mall_directory),
            label: 'Услуги',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Чаты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
