import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:fireter/constants.dart';

Future<void> weather() async {
  String key = '57469bdd737a35670d966f80a8d64451';
  String url = 'http://api.openweathermap.org/data/2.5/weather?';
  String fullurl = url + "q=" + "kollam" + "&appid=" + key;
  Uri fullurl1 = Uri.parse(fullurl);
  var response = await http.post(fullurl1);
  late var body = json.decode(response.body);
}
