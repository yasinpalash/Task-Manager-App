
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../Screens/loginScreen.dart';
import '../Screens/update-profile-screen.dart';
import '../utils/auth-utils.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {

  dynamic photo;

  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes=const Base64Decoder().convert(AuthUtils.profilePic??'');
    return ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        leading: CircleAvatar(
            child: ClipOval(
              child: Image.memory(imageBytes))),
        title: Text(
          '${AuthUtils.firstName ?? ''} ${AuthUtils.lastName ?? ''}',
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          AuthUtils.email ?? 'Unknown',
          style: const TextStyle(color: Colors.white),
        ),
        tileColor: Colors.green,
        trailing: IconButton(
          onPressed: () {
            AuthUtils.clearData();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          },
          icon: const Icon(
            Icons.login_outlined,
            color: Colors.white,
          ),
        ));
  }
}
