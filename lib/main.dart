import 'package:batiment_application/auth/login.dart';
import 'package:batiment_application/auth/wrapper.dart';
import 'package:batiment_application/crud/Add2.dart';
import 'package:batiment_application/crud/infos.dart';
import 'package:batiment_application/home/HomePage.dart';
import 'package:batiment_application/service/authService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
      routes: {
        "login": (context) => LogIn(),
        "wrapper": (context) => Wrapper(),
        "homepage": (context) => HomePage(),
        "infohome": (context) => infoHome(),
        "addPhoto": (context) => AddPhoto(),
      },
    );
  }
}
