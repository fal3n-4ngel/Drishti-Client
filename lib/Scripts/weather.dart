// ignore_for_file: depend_on_referenced_packages, unused_local_variable
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<void> weather() async {
  String key = 'XXX';
  String url = 'http://api.openweathermap.org/data/2.5/weather?';
  String fullurl = "${url}q=kollam&appid=$key";
  Uri fullurl1 = Uri.parse(fullurl);
  var response = await http.post(fullurl1);
  late var body = json.decode(response.body);
}
