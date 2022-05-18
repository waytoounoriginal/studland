import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studland/pages/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:studland/colors.dart';
import 'package:studland/pages/home.dart';

late Widget Page;


Future<void> _authUser() async {

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  var password = prefs.getString('password');

  try {
    var url = Uri.parse('https://automemeapp.com/StudLand/login.php');
    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });
    if(response.statusCode != 200) {

    } else {
      var jsondata = json.decode(response.body);
      print(jsondata);

      if(jsondata['error']){
        Page = const Login();
      }

      if(jsondata['success']){

        Page = const Home();

      }

    }
  } catch(e, stacktrace) {
    print(e);
    print(stacktrace);
    Page = const Login();

  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _authUser();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: Colors.white,


      ),
      home: Page,
    );
  }
}

