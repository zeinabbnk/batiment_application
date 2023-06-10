import 'package:batiment_application/crud/AddPanne.dart';
import 'package:batiment_application/home/HomePage.dart';
import 'package:batiment_application/service/FireBaseCRUD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
      backgroundColor: Color(0xFFeaf1f3),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AddPanne()),
            (Route<dynamic> route) => false,
          );
        },
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 30,
        ),
        backgroundColor: Color(0xFF95af50),
      ),
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
                        Text("Ajouter Un Bâtiment",
                            style: TextStyle(
                                fontSize: 20,
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
          SizedBox(height: 10,),
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: AdressController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Color(0xFF9fbdc2), width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Color(0xFF9fbdc2), width: 3),
                        ),
                        labelText: "Adress ",
                        icon:
                            Icon(Icons.location_city, color: Color(0xFF4d6d7c)),
                        labelStyle: TextStyle(
                            color: Color(0xFF4d6d7c),
                            fontWeight: FontWeight.bold),
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
                          borderSide:
                              BorderSide(color: Color(0xFF9fbdc2), width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Color(0xFF9fbdc2), width: 3),
                        ),
                        labelText: "Type de Bâtiment ",
                        icon:
                            Icon(Icons.house_rounded, color: Color(0xFF4d6d7c)),
                        labelStyle: TextStyle(
                            color: Color(0xFF4d6d7c),
                            fontWeight: FontWeight.bold),
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
                          borderSide:
                              BorderSide(color: Color(0xFF9fbdc2), width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Color(0xFF9fbdc2), width: 3),
                        ),
                        labelText: "Nombre d'étages ",
                        icon: Icon(Icons.stairs, color: Color(0xFF4d6d7c)),
                        labelStyle: TextStyle(
                            color: Color(0xFF4d6d7c),
                            fontWeight: FontWeight.bold),
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
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var response = await FireBaseCRUD.addHouse(
                                Adress: AdressController.text,
                                TypeBatiment: typeBController.text,
                                NumEtage: EtagesController.text);
                            if (response.code == 200) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Informations Saved',
                                desc: response.message.toString(),
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              )..show();
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Save Failed',
                                desc: response.message.toString(),
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              )..show();
                            }
                          }
                          ;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file_outlined,
                              color: Color(0xFFeaf1f3),
                              size: 26,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Enregistrer",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFeaf1f3)),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF816856),
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
