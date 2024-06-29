
import 'package:flutter/material.dart';
import 'package:notes/model/user_model.dart';

class Chattile extends StatelessWidget {
  final UserModel userProfile;
  final Function ontap;
  const Chattile({super.key, required this.userProfile, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        ontap();
      },
      dense: false,
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(userProfile.profilePic!),
      ),
      title: Text(userProfile.name!),

    );
  }
}