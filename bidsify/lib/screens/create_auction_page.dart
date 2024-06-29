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

  onClick() async {
    final args = await Navigator.pushNamed(context, '/add_auction_page') as Map?;
    if (args != null) {
      setState(() {
        _auctionItems.add(
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AuctionItem(image: args['image'], title: args['title'], description: args['description']))
        );
      });
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 45, 0, 0),
            child: Text(
              'Create a new Auction',
              style: kHeadingTextStyle.copyWith(
                fontSize: 30
              ),
            ),
          ),

          Column(
            children: _auctionItems,
          ),

          SmallButtons(icon: Icon(Icons.add), text: 'Add an item', onClick: onClick),      

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
      height: 200,
      width: double.infinity,
      child: Row(
        children: [
          Image.file(image, fit: BoxFit.cover),
          Text(title),
          Text(description)
        ],
      ),
    );
  }
}