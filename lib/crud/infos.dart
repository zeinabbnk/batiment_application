import 'package:flutter/material.dart';

class infoHome extends StatefulWidget {
  const infoHome({super.key});

  @override
  State<infoHome> createState() => _infoHomeState();
}

class _infoHomeState extends State<infoHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: const [
            Text("Enter les Informations "),
            TextField(
              decoration: InputDecoration(
                labelText: "adress ",
                icon: Icon(Icons.location_city),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Type de Batiment ",
                icon: Icon(Icons.house),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Nombre d etages ",
                icon: Icon(Icons.stairs),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
