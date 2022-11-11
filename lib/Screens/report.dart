// ignore_for_file: depend_on_referenced_packages, camel_case_types, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:fireter/Mongo/mongovars.dart';
import 'package:fireter/Mongo/mongodb.dart';
import 'package:fireter/constants.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

class reportui extends StatefulWidget {
  reportui({Key? key}) : super(key: key);

  @override
  State<reportui> createState() => _reportui();
}

class _reportui extends State<reportui> {
  String user = 'user';

  final myloc = TextEditingController();
  final myint = TextEditingController();
  final mytyp = TextEditingController();
  final mydet = TextEditingController();
  final myrem = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myloc.dispose();
    myint.dispose();
    mytyp.dispose();
    mydet.dispose();
    myrem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController locationController = TextEditingController();
    TextEditingController gradeController = TextEditingController();
    TextEditingController facultyController = TextEditingController();
    TextEditingController alertController = TextEditingController();
    TextEditingController detailsController = TextEditingController();

    double height = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();

    // List of items in our dropdown menu
    double formpad = 10;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.symmetric(vertical: height / 15),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              elevation: 4,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      '\n Report \n',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Comfortaa',
                          fontSize: 36,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    Container(
                      padding: EdgeInsets.all(formpad),
                      width: 750.0,
                      child: TextFormField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(formpad),
                      width: 750.0,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[1-3.,]')),
                        ],
                        controller: gradeController,
                        decoration: const InputDecoration(
                          labelText: "Intensity Grade(1-3)",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(formpad),
                      width: 750.0,
                      child: TextFormField(
                        controller: alertController,
                        decoration: const InputDecoration(
                          labelText: 'Type / Heading',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(formpad),
                      width: 750.0,
                      child: TextFormField(
                        controller: detailsController,
                        decoration: const InputDecoration(
                          labelText: 'Details',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(formpad),
                      width: 750.0,
                      child: TextFormField(
                        controller: facultyController,
                        decoration: const InputDecoration(
                          labelText: 'Forward to',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                padding: EdgeInsets.all(10),
                                duration: Duration(milliseconds: 800),
                                content: Text('Submitting Data')),
                          );
                          setState(() {
                            final auth = FirebaseAuth.instance;
                            var user1 = auth.currentUser?.displayName;
                            user = "$user1";
                            location = locationController.text;
                            grade = gradeController.text;
                            alert = alertController.text;
                            details = detailsController.text;
                            faculty = facultyController.text;
                            nam = user;
                            MongoDatabase.push(
                                location, faculty, grade, alert, details, nam);
                          });
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: 'Comfortaa',
                            fontSize: 25,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
