import 'package:flutter/material.dart';
import 'package:studland/colors.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studland/pages/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {

  Duration get loginTime => const Duration(milliseconds: 0);

  Future<String?> _authUser(LoginData data) async {
    try {
      var url = Uri.parse('https://automemeapp.com/StudLand/login.php');
      final response = await http.post(url, body: {
        'email': data.name,
        'password': data.password,
      });
      if(response.statusCode != 200) {
        return 'Cannot connect. Please try again later.';
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);

        if(jsondata['error']){
          return jsondata['message'];
        }

        if(jsondata['success']){
          return null;
        }

      }
    } catch(e) {
      print(e);
      return 'Cannot connect. Please try again later.';
    }
  }

  Future<String?> _signupUser(SignupData data) async {

    try {
      var url = Uri.parse('https://automemeapp.com/StudLand/register.php');
      final response = await http.post(url, body: {
        'email': data.name,
        'password_1': data.password,
        'password_2': data.password,
      });
      if(response.statusCode != 200) {
        return 'Cannot connect. Please try again later.';
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);

        if(jsondata['error']){
          return jsondata['message'];
        }

        if(jsondata['success']){
          return null;
        }

      }
    } catch(e) {
      print(e);
      return 'Cannot connect. Please try again later.';
    }
  }

  Future<String?> _recoverPassword(String name) async {

  }






  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: Image.asset('assets/logo_png.png').image,
      theme: LoginTheme(
        accentColor: Colors.white,
        primaryColor: Palette.ghostWhite,
        cardTheme: const CardTheme(
          color: Palette.carGreen,
          elevation: 0,
        ),
        titleStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Palette.carGreen,
        ),
        buttonTheme: LoginButtonTheme(
          backgroundColor: Palette.carGreen,
        )
      ),

      onLogin: _authUser,
      onRecoverPassword: _recoverPassword,
      onSignup: _signupUser,

      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      },

    );
  }
}


