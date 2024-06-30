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
        child: Column(
          children: [
             Expanded(
            child: StreamBuilder(
              stream: _bidService.getItemsbyownerid(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No items found'));
                }

                final items = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    ItemModel item = items[index].data();
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: BidCard(
                        title: item.name,
                        bidder: _authService.user!.uid,
                        latestBid: item.price,
                        onClick: () {},
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ],
        ),
      ),
    );
  }
}
