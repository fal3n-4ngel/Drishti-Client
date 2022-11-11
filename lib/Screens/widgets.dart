// ignore_for_file: unnecessary_const

import 'package:fireter/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fireter/Mongo/mongovars.dart';
import 'package:fireter/Mongo/mongodb.dart';

Widget none() {
  // Blank area in case of no widget..
  return Container();
}

Widget card2(index, refresh) {
  late var loc = data[index]["location"];
  late var fac = data[index]["faculty"];
  late var grad = data[index]["grade"];
  late var aler = data[index]["alert"];
  late var detail = data[index]["details"];
  late var nam1 = data[index]["name"];
  late var id = data[index]["_id"];
  nam1 ??= "Anonymous";
  var color = const Color.fromARGB(255, 205, 240, 7);

  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    elevation: 5,
    child: ExpansionTile(
      tilePadding: const EdgeInsets.all(10),
      subtitle: Text("Location: $loc"),
      title: title(aler, color, grad),
      children: <Widget>[
        ListTile(
            title: Text(
          "Details: $detail \nForwarded to: $fac\n\n  Reported by $nam1",
          style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'Comfortaa',
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.w300,
              height: 1),
        )),
        (user == "admin31007")
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  // ignore: prefer_const_constructors
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    MongoDatabase.remov(id);
                    refresh();
                  },
                  child: const Text(
                    'Remove',
                    style: const TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontFamily: 'Comfortaa',
                        fontSize: 25,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ),
              )
            : const Text(""),
      ],
    ),
  );
}

Widget title(aler, color, grad) {
  if (grad == '3' || grad == 3) {
    color = const Color.fromARGB(255, 240, 7, 7);
  } else if (grad == '2' || grad == 2) {
    color = const Color.fromARGB(255, 236, 147, 37);
  } else {
    color = const Color.fromARGB(255, 255, 207, 16);
  }
  if (kDebugMode) {
    print(grad);
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.only(top: 13),
        child: Icon(
          Icons.report,
          color: color,
          size: 50,
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 25),
        child: Text(
          "$aler",
          style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'Comfortaa',
              fontSize: 28,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
      ),
      const SizedBox(
        width: 40,
      ),
    ],
  );
}
