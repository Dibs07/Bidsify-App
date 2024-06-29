import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
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
              child: TextButton(
                // style: ButtonStyle(
                //   backgroundColor:  Colors.black,
                // ),
                onPressed: () {},
                child: Text('Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
