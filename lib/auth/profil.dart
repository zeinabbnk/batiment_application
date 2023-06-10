import 'dart:ffi';

import 'package:batiment_application/models/boxText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/HomePage.dart';

class profilPage extends StatefulWidget {
  const profilPage({super.key});

  @override
  State<profilPage> createState() => _profilPageState();
}

class _profilPageState extends State<profilPage> {
  final currentUser = FirebaseAuth.instance.currentUser;

//editName
  Future<void> editField(String text) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                    color: Color(0xFF356762),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Column(children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Color(0xFFeaf1f3),
                          ),
                        ),
                        Text("Profile",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFeaf1f3))),
                        Image.asset(
                          "images/logo.png",
                          color: Color(0xFFeaf1f3),
                          height: 50,
                          width: 50,
                        ),
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Positioned(
            top: 120,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFeaf1f3),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6.0,
                    offset: Offset(0.0, 0.0),
                  )
                ],
              ),
              height: 550,
              width: 340,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                //image
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Image.asset(
                    "images/profil.png",
                    color: Color(0xFF394867),
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                //user email
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Email :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF394867)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      currentUser!.email!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),

                //user details
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 42, top: 10, bottom: 10),
                  child: Text(
                    "Mes informations",
                    style: TextStyle(
                      
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF394867)),
                  ),
                ),
                textBox(
                  text: 'Zainab',
                  sectionName: "Nom d'utilisateur    :",
                  onPress: () => editField('userName'),
                )
              ]),
            ),
          ),
        ],
      )),
    );
  }
}
