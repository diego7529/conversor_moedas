import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'screen/home_page.dart';

const request = "https://api.hgbrasil.com/finance?key=911af50b";

void main() async {
  runApp( MaterialApp(
    home: const Home(),
    theme: ThemeData(
      hintColor: Colors.green,
      primaryColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        hintStyle: TextStyle(color: Colors.green),
      )),
  ));
}

Future<Map?> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}
