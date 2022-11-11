// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class ProfileScreenUi extends StatefulWidget {
  const ProfileScreenUi({Key? key}) : super(key: key);

  @override
  State<ProfileScreenUi> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfileScreenUi> {
  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      // no providerConfigs property here as well
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, '/signin');
        }),
      ],
      children: [
        Text("Primary Location : Thiruvanathapuram"),
        ElevatedButton(
            onPressed: () {
              throw Exception("test");
            },
            child: Text("Crash App"))
      ],
    );
  }
}
