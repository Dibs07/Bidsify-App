import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/services/auth_service.dart';
import 'package:notes/services/data_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthService _authService;
late DataService _dataService;

  late Future<void> _loadUserDataFuture;
   String _displayName = '';
  String _profilepic = '';
  @override
  void initState() {
    super.initState();
    _authService = GetIt.instance.get<AuthService>();
_dataService = GetIt.instance.get<DataService>();
    if (_authService.user == null) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMobileBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                child: Text(
                  'Welcome,${_displayName}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                children: [
                  Image(
                    image: AssetImage('assets/Ether-no-bg.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Text("Wallet",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20.0,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "Buy ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
