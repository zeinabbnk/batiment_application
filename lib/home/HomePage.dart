import 'package:batiment_application/home/Drawer/Home_screen.dart';
import 'package:batiment_application/home/Drawer/Screen_dawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [
          ScreenDrawer(),
          HomeScreen(),
        ]),
      ),
    );
  }
}
