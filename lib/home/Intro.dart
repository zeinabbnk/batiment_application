import 'package:flutter/material.dart';
import 'package:batiment_application/crud/infos.dart';
import 'package:batiment_application/home/HomePage.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<Widget> _pages = [
    infoHome(),
    HomePage(),
  ];
  int _selectedItem  = 0 ;

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedItem),
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          backgroundColor: Color(0xFFBAD7E9),
          iconSize: 30,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          selectedItemColor: Color(0xFF394867),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_home_outlined,
                ),
                label: "InfoHome"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: "HomePage"),
          ]),
    );
  }
}
