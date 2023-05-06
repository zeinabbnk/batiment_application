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
        margin: EdgeInsets.only(top: 90),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Text(
              "Entrer les Informations ",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                labelText: "adress ",
                icon: Icon(Icons.location_city, color: Color(0xFF2B3467)),
                labelStyle: TextStyle(
                    color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                labelText: "Type de Batiment ",
                icon: Icon(Icons.house, color: Color(0xFF2B3467)),
                labelStyle: TextStyle(
                    color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                labelText: "Nombre d etages ",
                icon: Icon(Icons.stairs, color: Color(0xFF2B3467)),
                labelStyle: TextStyle(
                    color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){}, child:  Row(
                  children: [
                    Icon(
                      Icons.upload_file_outlined,
                      color: Color(0xFF2B3467),
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Upload Maquette",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2B3467)),
                    )
                  ],
                ),
                 style: ElevatedButton.styleFrom(
                  primary: Color(0xFFEB455F),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                )
           
          ],
        ),
      ),
    );
  }
}
