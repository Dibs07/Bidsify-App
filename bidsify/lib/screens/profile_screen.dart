import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/model/bid_model.dart';
import 'package:notes/model/item_model.dart';
import 'package:notes/model/user_model.dart';
import 'package:notes/services/auth_service.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/services/bid_service.dart';
import 'package:notes/services/data_service.dart';
import 'package:notes/widgets/auction_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthService _authService;
  late DataService _dataService;
  late BidService _bidService;
   late Future<void> _loadUserDataFuture;
   String _displayName = '';
  String _profilepic = '';
  @override
  void initState() {
    super.initState();
    _authService = GetIt.instance.get<AuthService>();
    _dataService = GetIt.instance.get<DataService>();
    _bidService = GetIt.instance.get<BidService>();
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

  logout() async {
    await _authService.logout();
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: logout,
            child: Padding(
              padding: EdgeInsets.only(right: 10.0, top: 5.0),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: kMobileBackgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Center(
              child: Image(
                image: NetworkImage(_profilepic),
                height: 100.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "${_displayName}",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                "${_authService.user!.email}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
           Expanded(
            child: StreamBuilder(
              stream: _bidService.getBidsbyownerID(),
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
                    BidModel item = items[index].data();
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: BidCard(
                        isHistory: true,
                        buttonText: '',
                        title: item.item,
                        bidder: _authService.user!.uid,
                        latestBid: item.maxBid,
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
