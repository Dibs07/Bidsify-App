import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/model/user_model.dart';
import 'package:notes/services/auth_service.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/services/data_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthService _authService;
  late DataService _dataService;
  late String _displayName;
  @override
  void initState() {
    super.initState();
    _authService = GetIt.instance.get<AuthService>();
    _dataService = GetIt.instance.get<DataService>();
    if (_authService.user == null) {
      Navigator.pushNamed(context, '/login');
    }
    Stream<QuerySnapshot<UserModel>> userModel =
        _dataService.getUser();
        _displayName = userModel!.name;
  }

  var bids = ["Bid1", "Bid2", "Bid3", "Bid4"];

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
        padding: EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            Center(
              child: Image(
                image: AssetImage('assets/default-profile.png'),
                height: 100.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "${_authService.user!.displayName}",
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
              child: ListView.builder(
                itemCount: bids.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          bids[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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
