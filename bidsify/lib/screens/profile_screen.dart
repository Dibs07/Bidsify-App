import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/services/auth_service.dart';
import 'package:notes/constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthService _authService;
  @override
  void initState() {
    super.initState();
    _authService = GetIt.instance.get<AuthService>();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            // style: ButtonStyle(
            //   backgroundColor:  Colors.black,
            // ),

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: AssetImage('assets/default-profile.png'),
                height: 100.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("Dibakar",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text("Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  logout() async {
    await _authService.logout();
    Navigator.pushNamed(context, '/login');
  }
}
