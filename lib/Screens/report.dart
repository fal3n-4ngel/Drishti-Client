import 'package:flutter/material.dart';
import 'package:fireter/Mongo/mongovars.dart';
import 'package:fireter/Mongo/mongodb.dart';

class reportui extends StatefulWidget {
  reportui({Key? key}) : super(key: key);

  @override
  State<reportui> createState() => _reportui();
}

class _reportui extends State<reportui> {
  @override
  String user = 'user';
  int _index = 0;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    String dropdownvalue = '1';

    // List of items in our dropdown menu
    var items = ['1', '2', '3'];
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
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Text(
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
                    )),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Intensity Grade",
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: 'Comfortaa',
                                    fontSize: 18,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w300,
                                    height: 1)),
                            DropdownButton(
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ],
                        )),
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
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          setState(() {
                            location = locationController.text;
                            grade = dropdownvalue;
                            alert = alertController.text;
                            details = detailsController.text;
                            faculty = facultyController.text;
                            MongoDatabase.push(
                                location, faculty, grade, alert, details);
                          });
                        }
                      },
                      child: Text(
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
                    SizedBox(
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
