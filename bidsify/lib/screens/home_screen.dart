import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:notes/screens/main_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Search Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    Text(
      'Profile Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    Text(
      'Profile Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMobileBackgroundColor,
      // appBar: AppBar(
      //   title: Text('Bottom Navigation Bar Example'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(EneftyIcons.home_2_outline),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:  Icon(EneftyIcons.add_circle_outline),
            label: 'Add a Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(EneftyIcons.note_2_outline),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(EneftyIcons.profile_2user_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: kMobileBackgroundColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 74, 74, 87),
        iconSize: 25,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
