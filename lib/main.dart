import 'package:batiment_application/auth/SignUp.dart';
import 'package:batiment_application/auth/login.dart';
import 'package:batiment_application/crud/Add.dart';
import 'package:batiment_application/crud/Add2.dart';
import 'package:batiment_application/crud/infos.dart';
import 'package:batiment_application/home/HomePage.dart';
import 'package:batiment_application/home/Intro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogIn(),
      routes: {
        "login": (context) => LogIn(),
        "signup": (context) => SignUp(),
        "homepage": (context) => HomePage(),
        "IntroPage": (context) => IntroPage(),
        "addMaquette": (context) => AddMqt(),
        "infohome": (context) => infoHome(),
        "addPhoto": (context) => AddPhoto(),
      },
    );
  }
}
