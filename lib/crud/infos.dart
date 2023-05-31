import 'package:batiment_application/service/FireBaseCRUD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/login_page.dart';

class infoHome extends StatefulWidget {
  const infoHome({super.key});

  @override
  State<infoHome> createState() => _infoHomeState();
}

class _infoHomeState extends State<infoHome> {
  final AdressController = TextEditingController();
  final typeBController = TextEditingController();
  final EtagesController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final currUsers = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBAD7E9),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color(0xFFBAD7E9)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color(0xFFEB455F),
                  child: Text(
                    "Z",
                    style: TextStyle(
                        color: Color(0xFF394867),
                        fontWeight: FontWeight.w600,
                        fontSize: 40),
                  ),
                ),
                accountName: Text(
                  "Zeinab",
                  style: TextStyle(color: Color(0xFF394867)),
                ),
                accountEmail:
                    Text("Hello", style: TextStyle(color: Color(0xFF394867)))),
            Card(
              color: Color(0xFFBAD7E9),
              child: ListTile(
                title: Text(
                  "Home Page",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF394867),
                      fontWeight: FontWeight.w700),
                ),
                leading: Icon(
                  Icons.home,
                  size: 28,
                  color: Color(0xFF394867),
                ),
                onTap: () {},
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 500),
                child: InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF394867)),
                  ),
                ))
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 32),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Enter The House Informations",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: AdressController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                  ),
                  labelText: "Adress ",
                  icon: Icon(Icons.location_city, color: Color(0xFF2B3467)),
                  labelStyle: TextStyle(
                      color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'The Field is required';
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: typeBController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                  ),
                  labelText: "Type de Bâtiment ",
                  icon: Icon(Icons.location_city, color: Color(0xFF2B3467)),
                  labelStyle: TextStyle(
                      color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'The Field is required';
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: EtagesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                  ),
                  labelText: "Nombre d'étages ",
                  icon: Icon(Icons.stairs, color: Color(0xFF2B3467)),
                  labelStyle: TextStyle(
                      color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'The Field is required';
                  }
                },
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: 180,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var response = await FireBaseCRUD.addHouse(
                          Adress: AdressController.text,
                          TypeBatiment: typeBController.text,
                          NumEtage: EtagesController.text);
                      if (response.code != 200) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(response.message.toString()),
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(response.toString()),
                            );
                          },
                        );
                      }
                    }
                    ;
                    Navigator.of(context).pushNamed("AddPanne");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload_file_outlined,
                        color: Color(0xFF2B3467),
                        size: 26,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Commencer",
                        style: TextStyle(
                            fontSize: 18,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
