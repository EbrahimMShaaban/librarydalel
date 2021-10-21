import 'package:flutter/material.dart';
import 'package:librarydalel/constant/styles.dart';
import 'package:librarydalel/screens/user/profile_screen/View.dart';
import 'package:librarydalel/screens/user/search_screen/search.dart';

import 'home_screen/view.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int pageindex = 1;
  List<Widget> pages = [
    //ToDo
    Seerch(),
    const HomePageScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageindex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: white2,
          unselectedItemColor: gray,
          selectedItemColor: purple,
          iconSize: 35,
          type: BottomNavigationBarType.fixed,
          currentIndex: pageindex,
          onTap: (value) {
            setState(() {
              pageindex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ]),
    );
  }
}
