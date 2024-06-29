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
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BidCard(
                  title: 'Here Goes Auction 1',
                  bidder: {"name": "Sayan"},
                  latestBid: 0.0,
                  currentBid: 10.0,
                  onClick: onClick,
                  transactionId: "15688446511555555555555555555555555555551846318546846",
                )),
          ],
        ),
      ),
    );
  }
}
