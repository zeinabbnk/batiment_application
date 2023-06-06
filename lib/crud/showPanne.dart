import 'package:batiment_application/service/FireBaseCRUD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

CollectionReference Houses = FirebaseFirestore.instance.collection('House');
final Stream<QuerySnapshot> refHouse = FireBaseCRUD.showHouse();

class showPanne extends StatelessWidget {
  const showPanne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
                color: Color(0xFF356762),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child: Row(
              children: [
                Text("Rapport"),
                Image.asset(
                  "images/logo.png",
                  height: 50,
                  width: 50,
                )
              ],
            ),
          ),
          Positioned(
            top: 90,
            child: Column(children: [
              Container(
                alignment: Alignment.topRight,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                fontSize: 14,
                                                color: Colors.black),
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
                                                fontSize: 14,
                                                color: Colors.black),
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
                                                fontSize: 14,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
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
          )
        ]),
      ),
    );
    ;
  }
}
