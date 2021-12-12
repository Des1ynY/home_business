import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '/appdata/consts.dart';
import '/ui/home/chat/chatrooms.dart';
import '/ui/home/orders/orders.dart';
import '/ui/home/people/neighbourhoods.dart';
import '/ui/home/profile/profile.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  static const List<Widget> _screens = <Widget>[
    Residents(),
    HomeServices(),
    Chatrooms(),
    AppUserProfile(),
  ];
  static final List<AppBar> _appbars = <AppBar>[
    AppBar(
      title: const Text('Соседи'),
      centerTitle: true,
    ),
    AppBar(
      title: const Text('Услуги'),
      centerTitle: true,
      bottom: const TabBar(
        indicatorColor: primaryColor,
        labelColor: primaryColor,
        unselectedLabelColor: hintTextColor,
        labelStyle: TextStyle(
          fontFamily: 'AvenirNextCyr',
          fontSize: 16,
        ),
        tabs: [
          Tab(text: 'Соседей'),
          Tab(text: 'Ваши'),
        ],
      ),
    ),
    AppBar(
      title: const Text('Чаты'),
      centerTitle: true,
    ),
    AppBar(
      title: const Text('Профиль'),
      centerTitle: true,
    ),
  ];
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: _screens.elementAt(_currentIndex),
        appBar: _appbars.elementAt(_currentIndex),
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
      ),
    );
  }
}
