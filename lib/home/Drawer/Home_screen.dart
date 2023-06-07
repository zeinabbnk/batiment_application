import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:batiment_application/crud/report.dart';
import 'package:batiment_application/models/House.dart';
import 'package:batiment_application/service/FireBaseCRUD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../crud/AddPanne.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xoffset = 0;
  double yoffset = 0;

  bool isDrawerOpen = false;
  CollectionReference Houses = FirebaseFirestore.instance.collection('House');
  final Stream<QuerySnapshot> refHouse = FireBaseCRUD.showHouse();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xoffset, yoffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Color(0xFFF1F6F9),
        borderRadius: BorderRadius.circular(40),
      ),
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                isDrawerOpen
                    ? GestureDetector(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF356762),
                        ),
                        onTap: () {
                          setState(() {
                            xoffset = 0;
                            yoffset = 0;
                            isDrawerOpen = false;
                          });
                        },
                      )
                    : GestureDetector(
                        child: Icon(
                          Icons.menu,
                          color: Color(0xFF356762),
                        ),
                        onTap: () {
                          setState(() {
                            xoffset = 300;
                            yoffset = 80;
                            isDrawerOpen = true;
                          });
                        },
                      ),
                SizedBox(
                  width: 80,
                ),
                Text(
                  "Home Page",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF356762),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Image.asset(
                  "images/logo.png",
                  color: Color(0xFF356762),
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                )
              ],
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            height: 690,
            decoration: BoxDecoration(
                color: Color(0xFFeaf1f3),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 0))
                ]),
            child: StreamBuilder(
              stream: refHouse,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                        children: snapshot.data!.docs.map((e) {
                      return Container(
                        height: 220,
                        child: Card(
                          elevation: 20,
                          child: ListTile(
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete_outline_outlined,
                                size: 30,
                                color: Color(0xFFEB455F),
                              ),
                              onPressed: () async {
                                var response = await FireBaseCRUD.deleteHouse(
                                    houseId: e.id);
                                if (response.code == 200) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.rightSlide,
                                    title: 'Informations Deleted',
                                    desc: response.message.toString(),
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  )..show();
                                }
                              },
                            ),
                            title: Row(
                              children: [
                                Icon(
                                  Icons.house_rounded,
                                  color: Color(0xFF4d6d7c),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Informations de Bâtiment",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4d6d7c),
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Adresse : ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 18,
                                      ),
                                      Text(
                                        e['Adesse'],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Type de Bâtiment : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 18,
                                      ),
                                      Text(
                                        e['Type Bâtiment'],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Numéro d'étage : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 18,
                                      ),
                                      Text(
                                        e['Numéro étage'],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => report()),
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.file_open_rounded),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Rapport"),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF95af50)),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddPanne()),
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons
                                                .add_circle_outline_rounded),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "  Panne",
                                              // style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF95af50)),
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      );
                    }).toList()),
                  );
                }
                return Container();
              },
            ),
          )
        ]),
      ),
    );
  }
}
