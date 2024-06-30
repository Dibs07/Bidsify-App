import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/model/item_model.dart';
import 'package:notes/services/auth_service.dart';
import 'package:notes/services/bid_service.dart';
import 'package:notes/services/data_service.dart';
import 'package:notes/widgets/auction_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late BidService _bidService;
  late AuthService _authService;
  late DataService _dataService;
  late Future<void> _loadUserDataFuture;
  String _displayName = '';
  String _profilepic = '';
  VoidCallback onClick = () => {};

  @override
  void initState() {
    super.initState();
    _bidService = GetIt.instance.get<BidService>();
    _authService = GetIt.instance.get<AuthService>();
    _dataService = GetIt.instance.get<DataService>();

    if (_authService.user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/login');
      });
    } else {
      _loadUserDataFuture = _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    final userModelStream = _dataService.getUser();
    final event = await userModelStream.first;
    setState(() {
      _displayName = event.docs[0].data().name!;
      _profilepic = event.docs[0].data().profilePic;
    });
  }

  endBid() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 15),
        child: Column(
          children: [
            Center(
                child: Text(
              'My Items',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white 
              ),
            )),
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
                          isHistory: false,
                          buttonText: 'End Bid',
                          title: item.name,
                          bidder: item.lastBid,
                          latestBid: item.price,
                          onClick: endBid,
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
