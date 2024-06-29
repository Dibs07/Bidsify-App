import 'dart:ffi';

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/widgets/auction_card.dart';

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

  var value = 0;

  onClick() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Auction Details',
                style: kHeadingTextStyle.copyWith(
                  fontSize: 35
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              content: SizedBox(
                height: 210,
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          // validator: (val) => val!.length<6 ? 'Enter a valid name' : null,
                          // onSaved: (val) => _name = val!,
                          style: kInputTextFieldStyle,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Title',
                          ),
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            // name = value;
                          },
                        ),
                        const SizedBox(height: 20),
                    
                        TextFormField(
                          // validator: (val) => val!.isEmpty ? 'Enter a valid email' : null,
                          // onSaved: (val) => _email = val!,
                          style: kInputTextFieldStyle,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Initial Bid',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            // email = value;
                          },
                        ),
                    
                        // --------------ImagePicker Here----------------

                        // const SizedBox(height: 20),
                    
                        // TextFormField(
                        //   // validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                        //   // onSaved: (val) => _password = val!,
                        //   style: kInputTextFieldStyle,
                        //   decoration: kTextFieldDecoration.copyWith(
                        //     hintText: 'Enter your password',
                        //   ),
                        //   obscureText: true,
                        //   onChanged: (value) {
                        //     // email = value;
                        //   },
                        // ),
                    
                        // const SizedBox(height: 20),
                    
                        // TextFormField(
                        
                        //   style: kInputTextFieldStyle,
                        //   decoration: kTextFieldDecoration.copyWith(
                        //     hintText: 'Confirm password',
                        //   ),
                        //   obscureText: true,
                        //   onChanged: (value) {
                        //     // email = value;
                        //   },
                        // ),
                      ],
                    ),
                    SizedBox(height: 20),
                    myButton(width: double.infinity, height: 50, text: 'Save', onClick: (){})

                  ],
                ),
              ),
              // actions: [
              //   TextButton(
              //     child: Text('Close'),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //   ),
              // ],
            );
          },
        );
      },
    );
  }

  placeBid() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Place your Bid Here',
                style: kHeadingTextStyle.copyWith(
                  fontSize: 35
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              content: SizedBox(
                height: 130,
                child: Column(
                  children: [
                    
                    TextField(
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    myButton(width: double.infinity, height: 50, text: 'Save', onClick: (){})

                  ],
                ),
              ),
              // actions: [
              //   TextButton(
              //     child: Text('Close'),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //   ),
              // ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OptionsCard(
                    onClick: onClick,
                    title: 'Create a Bid',
                    icon: Icon(EneftyIcons.card_add_outline),
                    height: 90,
                    width: 175),
                OptionsCard(
                    onClick: () {},
                    title: 'Create an\nAuction',
                    icon: Icon(EneftyIcons.courthouse_outline),
                    height: 90,
                    width: 175),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AuctionCard(
              title: 'Here Goes Auction 1',
              bidder: {"Sayan": ""},
              initialBid: 0.0,
              currentBid: 10.2,
              onClick: placeBid
            ),
          ),
        ],
      ),
    );
  }
}
