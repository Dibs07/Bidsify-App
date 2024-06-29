import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';

class CreateAuctionPage extends StatefulWidget {
  const CreateAuctionPage({super.key});

  @override
  State<CreateAuctionPage> createState() => _CreateAuctionPageState();
}

class _CreateAuctionPageState extends State<CreateAuctionPage> {
  List<Widget> _auctionItems = [];
  List _toSubmit = [];

  onClick() async {
    final args = await Navigator.pushNamed(context, '/add_auction_page') as Map?;
    if (args != null) {
      setState(() {
        _auctionItems.add(
          Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: AuctionItem(image: args['image'], title: args['title'], description: args['description']))
        );
        _toSubmit.add(
          args
        );
      });
    }    
  }

  _onSubmit() {
    // toSubmit is a list of maps having keys : [image, title, description]
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 45, 20, 0),
            child: Text(
              'Create a new Auction',
              style: kHeadingTextStyle.copyWith(
                fontSize: 30
              ),
            ),
          ),
          SizedBox(height: 20,),
          Column(
            children: _auctionItems,
          ),

          Align(alignment: Alignment.center, child: SmallButtons(icon: Icon(Icons.add), text: 'Add an item', onClick: onClick)), 
          
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18.0, 18, 0),
            child: myButton(width: double.infinity, height: 50, text: 'Done', onClick: _onSubmit),
          )

        ] 
      ),
    );
  }
}





class AuctionItem extends StatelessWidget {
  final File image;
  final String title;
  final String description;
  const AuctionItem({super.key, required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kBackgroundColorButton,
        borderRadius: BorderRadius.circular(16), // Set rounded corners 
      ),
      child: Row(
        children: [
          SizedBox(width: 20,),
          SizedBox(height: 100, child: Image.file(image, fit: BoxFit.cover)),
          SizedBox(width: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                ),
              ),
              Text(description,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}