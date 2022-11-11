import 'package:fireter/Screens/contact.dart';
import 'package:fireter/Screens/home.dart';
import 'package:fireter/Screens/report.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:fireter/Mongo/mongodb.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return SignInScreen(
      // no providerConfigs property - global configuration will be used instead
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          Navigator.pushReplacementNamed(context, '/home');
        }),
      ],
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
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            child: Container(
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
                    )))));
  }
}
