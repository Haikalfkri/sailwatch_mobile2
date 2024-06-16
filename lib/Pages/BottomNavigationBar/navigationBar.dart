import 'package:flutter/material.dart';

import 'package:sailwatch_mobile/Pages/Homepage/home_page.dart';
import 'package:sailwatch_mobile/Pages/SearchPage/SearchPage.dart';
import 'package:sailwatch_mobile/Pages/Notification/notification.dart';
import 'package:sailwatch_mobile/Pages/LocalDataPage/localDataPage.dart';
import 'package:sailwatch_mobile/Pages/LoginPage/Login.dart';

class navigationBar extends StatefulWidget {
  const navigationBar({super.key});

  @override
  State<navigationBar> createState() => _navigationBarState();
}

class _navigationBarState extends State<navigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const searchPage(),
    const notification(),
    const localData(),
    const LoginScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF060821),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF2C2C2C), // Change the background color here
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF365B92),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/home.png")), label: ''),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/search.png")),
              label: ''),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/notification.png")),
              label: ''),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/local.png")), label: ''),
          BottomNavigationBarItem(  // Added Login Icon
              icon: ImageIcon(AssetImage("assets/icons/login.png")), label: '')
        ],
      ),
    );
  }
}
