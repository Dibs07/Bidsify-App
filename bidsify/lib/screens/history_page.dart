import 'package:flutter/material.dart';
import 'package:notes/widgets/auction_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  VoidCallback onClick = () => {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 15),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AuctionCard(
                  title: 'Here Goes Auction 1',
                  bidder: {"name": "Sayan"},
                  initialBid: 0.0,
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
