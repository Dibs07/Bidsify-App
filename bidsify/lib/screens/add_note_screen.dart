import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notes/constants/constants.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
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
    return const Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OptionsCard(title: 'Create a Bid', icon: Icon(EneftyIcons.card_add_outline), height: 90, width: 175),
                OptionsCard(title: 'Create an\nAuction', icon: Icon(EneftyIcons.courthouse_outline), height: 90, width: 175),
              ],
            ),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: OptionsCard(title: 'Auction 1', height: 190, width: double.infinity))
        ],
      ),
    );
  }
}
