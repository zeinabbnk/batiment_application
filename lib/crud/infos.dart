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
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Entrer les Informations de la Maison:",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEB455F)),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Adresse",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
