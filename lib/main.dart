// ignore_for_file: depend_on_referenced_packages, unused_import, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:fireter/Screens/home.dart';
import 'package:fireter/Screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireter/constants.dart';
import 'package:fireter/Screens/signin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fireter/Mongo/mongodb.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await MongoDatabase.connect();
  FlutterFireUIAuth.configureProviders([
    const EmailProviderConfiguration(),
  ]);
  final auth = FirebaseAuth.instance;
  user = auth.currentUser?.displayName;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    user = auth.currentUser?.displayName;
    return MaterialApp(
      initialRoute: "/splash",
      routes: {
        "/splash": (context) {
          return SplashScreen();
        }
      },
    );
  }
}

class MyAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    user = auth.currentUser?.displayName;

    return MaterialApp(
      initialRoute: auth.currentUser == null ? '/' : '/home',
      routes: {
        '/': (context) {
          return SignScreen();
        },
        '/profile': (context) {
          return ProfileScreenUi();
        },
        '/home': (context) {
          return MyHomePage(title: "Drishti");
        }
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  final String title = 'Komi';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Splash Screen Setup//
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyAppScreen())));
  }

  @override // Splash Screen Screen //
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
          alignment: Alignment.center,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Stack(children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Drishti",
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'NovaSlim',
                    fontSize: 36,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
            ),
          ])),
    );
  }
}
