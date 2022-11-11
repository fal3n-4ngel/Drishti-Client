// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fireter/Screens/home.dart';
import 'package:fireter/Screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:fireter/constants.dart';
import 'package:fireter/Screens/signin.dart';
import 'package:fireter/Mongo/mongodb.dart';
import 'dart:async';
import 'package:fireter/Screens/contact.dart';
import 'package:fireter/Screens/report.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Flutter',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  await MongoDatabase.connect();
  FlutterFireUIAuth.configureProviders([
    const EmailProviderConfiguration(),
  ]);
  runApp(const MyApp());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    user = auth.currentUser?.displayName;

    return MaterialApp(
      initialRoute: auth.currentUser == null ? '/signin' : '/home',
      routes: {
        '/signin': (context) {
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 0;
  final _pageOptions = [HomeScreen(), reportui(), ContactScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pageOptions[selectedPage],
        bottomNavigationBar: Card(
            margin: EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home, size: 30), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.add_location_alt, size: 30),
                        label: 'Report'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.contact_mail, size: 30),
                        label: 'Contact'),
                  ],
                  selectedItemColor: Color.fromARGB(255, 0, 0, 0),
                  elevation: 20.0,
                  unselectedItemColor: Color.fromARGB(95, 36, 36, 36),
                  currentIndex: selectedPage,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  onTap: (index) {
                    setState(() {
                      MongoDatabase.fetch();
                      selectedPage = index;
                    });
                  },
                ))));
  }
}
