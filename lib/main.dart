import 'package:batiment_application/crud/AddPanne.dart';
import 'package:batiment_application/crud/infos.dart';
import 'package:batiment_application/crud/report.dart';
import 'package:batiment_application/crud/showPanne.dart';
import 'package:batiment_application/home/HomePage.dart';
import 'package:batiment_application/home/welcome.dart';
import 'package:batiment_application/service/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      StreamProvider.value(
        initialData: null,
        value: AuthService().user,
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return welcome();
          } else {
            return const LoginPage();
          }
        },
      ),
      routes: {
        "welcome": (context) => welcome(),
        "homepage": (context) => HomePage(),
        "infohome": (context) => infoHome(),
        "AddPanne": (context) => AddPanne(),
        "Report":(context) => report(),
        "showPanne":(context) => showPanne(),
      },
    );
  }
}
