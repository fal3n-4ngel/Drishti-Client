// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors
import 'dart:async';

import 'package:fireter/Mongo/mongovars.dart';
import 'package:fireter/Mongo/mongodb.dart';
import 'package:fireter/Screens/profile.dart';
import 'package:fireter/Screens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fireter/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

Future<void> dataset(refresh, context) async {
  // weather fetching data
  try {
    String key = '57469bdd737a35670d966f80a8d64451';
    String url = 'http://api.openweathermap.org/data/2.5/weather?';
    String fullurl = "${url}q=thiruvananthapuram&appid=$key";
    Uri fullurl1 = Uri.parse(fullurl);
    var response = await http.post(fullurl1);
    late var body = json.decode(response.body);
    weather1 = body['weather'][0]['main'];
    var temp = body['main']['temp'] - 273.15;
    temperature = temp.toStringAsFixed(1);
    image1 = AssetImage("assets/Clouds.png");
    humidity = body['main']['humidity'].toStringAsFixed(1);
    refresh();
  } catch (e) {}
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  refresh() {
    setState(() {
      MongoDatabase.fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      data = [];
      net = false;
    }

    int n = data.length - 1;
    dataset(refresh, context);
    setState(() {});
    if (user == null) {
      setState(() {
        user = "User";
      });
    }

    return Scaffold(
      body: Column(children: [
        // Home Screen app bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  " Hello $user,",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Comfortaa',
                      fontSize: 36,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w300,
                      height: 1),
                )),
            Container(
              padding: EdgeInsets.only(top: 45, right: 10),
              child: IconButton(
                  iconSize: 40,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfileScreenUi();
                        },
                      ),
                    );

                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.person,
                  )),
            ),
          ],
        ),
        // Home Screen app bar END

        Card(
            // waether card...

            margin: EdgeInsets.all(20),
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(0),
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: image1,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Weather: $weather1",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Comfortaa',
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                              height: 1)),
                      Text("Temperature: $temperature °C",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Comfortaa',
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                              height: 1)),
                      Text("Humidity: $humidity",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Comfortaa',
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                              height: 1)),
                    ],
                  ),
                ],
              ),
            )),

        // waether card END
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.topLeft,
          child: Text(
            "Latest Alerts!",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Comfortaa',
                fontSize: 36,
                letterSpacing: 0,
                fontWeight: FontWeight.w200,
                height: 1),
          ),
        ),

        SizedBox(
          //   %%%% The List View
          height: 330,
          child: net
              ? ListView.builder(
                  padding: EdgeInsets.all(15),
                  itemCount: n,
                  itemBuilder: (BuildContext context, int index) {
                    return card2(n - index, refresh);
                  })
              : Image(image: AssetImage("assets/noalerts.jpg")),
        ),
      ]),
    );
  }
}
