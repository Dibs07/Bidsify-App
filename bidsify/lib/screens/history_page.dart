import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/model/item_model.dart';
import 'package:notes/services/auth_service.dart';
import 'package:notes/services/bid_service.dart';
import 'package:notes/widgets/auction_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late BidService _bidService;
  late AuthService _authService;
  VoidCallback onClick = () => {};

  @override
  void initState() {
    super.initState();
    _bidService = GetIt.instance.get<BidService>();
    _authService = GetIt.instance.get<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 15),
        child: StreamBuilder<List<ItemModel>>(
          stream: _bidService.getItemsbyownerid(ownerId:_authService.user!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No items found'));
            } else {
              var items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: BidCard(
                      title: item.name,
                      ownerid:item.ownerId!,
                      currentBid: item.price,
                      onClick: onClick,
                      pfp: item.itemPic!,
                      
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
