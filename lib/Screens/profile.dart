import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:fireter/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireter/constants.dart';
import 'package:fireter/Screens/signin.dart';
import 'package:fireter/Screens/home.dart';

class ProfileScreenUi extends StatefulWidget {
  const ProfileScreenUi({Key? key}) : super(key: key);

  @override
  State<ProfileScreenUi> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfileScreenUi> {
  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      children: [
        Container(
          child: Text("Some Important text"),
        ),
      ],
      // no providerConfigs property here as well
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, '/');
        }),
      ],
    );
  }
}
