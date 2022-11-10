import 'package:flutter/material.dart';
import 'package:fireter/Mongo/mongovars.dart';
import 'package:fireter/Mongo/mongodb.dart';

Widget none() {
  // Blank area in case of no widget..
  return Container();
}

Widget det(i) {
  MongoDatabase.fetch();
  // Data for expand.
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            "Location: $loc",
            style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Comfortaa',
                fontSize: 18,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Grade: $grad",
            style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Comfortaa',
                fontSize: 18,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        )
      ]),
      SizedBox(
        height: 20,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Text(
            "Details: $detail",
            textAlign: TextAlign.justify,
            style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Comfortaa',
                fontSize: 18,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
      ])
    ],
  );
}

Widget card1(var i, context, notifyParent, expand) {
  late var data1 = data[i];
  late var loc = data[i]["location"];
  late var fac = data[i]["faculty"];
  late var grad = data[i]["grade"];
  late var aler = data[i]["alert"];
  late var detail = data[i]["details"];
  var exp = expand;

  // main reports card
  return Card(
    color: Color.fromARGB(171, 255, 255, 255),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    elevation: 10,
    child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        height: exp ? 180 : 80,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 13),
                child: const Icon(
                  Icons.report,
                  color: Color.fromARGB(255, 240, 7, 7),
                  size: 50,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 25),
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
              Container(
                padding: EdgeInsets.only(top: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      expand = !expand;
                      exp = !exp;
                      notifyParent();
                    },
                    child: Icon(
                      !exp ? Icons.arrow_downward : Icons.arrow_upward,
                      size: 35,
                    )),
              )
            ],
          ),
          expanded ? det(i) : none()
        ])),
  );
}

Widget card2(index) {
  late var data1 = data[index];
  late var loc = data[index]["location"];
  late var fac = data[index]["faculty"];
  late var grad = data[index]["grade"];
  late var aler = data[index]["alert"];
  late var detail = data[index]["details"];
  var color = Color.fromARGB(255, 205, 240, 7);

  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    elevation: 5,
    child: ExpansionTile(
      tilePadding: EdgeInsets.all(10),
      subtitle: Text("Location: $loc"),
      title: title(aler, color, grad),
      children: <Widget>[
        ListTile(title: Text('Details: $detail')),
      ],
    ),
  );
}

Widget title(aler, color, grad) {
  if (grad == '3') {
    color = Color.fromARGB(255, 240, 7, 7);
  } else if (grad == '2') {
    color = Color.fromARGB(255, 236, 147, 37);
  } else {
    color = Color.fromARGB(255, 255, 207, 16);
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(top: 13),
        child: Icon(
          Icons.report,
          color: color,
          size: 50,
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 25),
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
