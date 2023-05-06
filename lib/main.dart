import 'package:batiment_application/auth/SignUp.dart';
import 'package:batiment_application/auth/login.dart';
import 'package:batiment_application/crud/Add.dart';
import 'package:batiment_application/crud/infos.dart';
import 'package:batiment_application/home/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: infoHome(),
      routes: {
        "login": (context) => LogIn(),
        "signup": (context) => SignUp(),
        "homepage": (context) => HomePage(),
        "addcommentaire": (context) => AddCmt(),
        "infohome" :(context) => infoHome(),
      },
    );
  }
}
