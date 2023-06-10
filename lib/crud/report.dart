import 'package:batiment_application/crud/rapportScreen.dart';
import 'package:batiment_application/home/HomePage.dart';
import 'package:batiment_application/models/maquetteList.dart';
import 'package:batiment_application/service/FireBaseCRUD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Rapport extends StatefulWidget {
  const Rapport({
    super.key,
  });

  @override
  State<Rapport> createState() => _RapportState();
}

class _RapportState extends State<Rapport> {
  // CollectionReference pannesCollection = FirebaseFirestore.instance
  //     .collection('HousePanne')
  //     .doc('PanneId')
  //     .collection('pannes');
  List<Map<String, dynamic>> pannes = [];
  final String _typePanne = '';
  final String _imageUrl = '';
  final String _text = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeaf1f3),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF95af50),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
        },
        child: Icon(
          Icons.done_outline,
          size: 30,
        ),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rapport",
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFeaf1f3))),
                        SizedBox(
                          width: 70,
                        ),
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
              height: 650,
              width: 340,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 8),
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
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => screenRapport()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: Text(
                                "Consultaion des Maquettes",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF95af50)),
                              ))),
                      Container(
                        margin: EdgeInsets.only(left: 18, bottom: 10, top: 18),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Les Pannes détectées :",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Color(0xFF4d6d7c)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Image.asset(
                          'images/électrique.jpg',
                          height: 150,
                          width: 180,
                          alignment: Alignment.center,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Type de Panne :",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Problème électrique"),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("commentaire :",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "on a détecté une panne électrique dans l'étage numéro 1",
                          ),
                        ],
                      ),
                      // Container(
                      //   margin: EdgeInsets.symmetric(vertical: 15),
                      //   child: Image.asset(
                      //     'images/4.png',
                      //     height: 80,
                      //     width: 80,
                      //     alignment: Alignment.center,
                      //   ),
                      // ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Type de Panne :",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.w600, fontSize: 16),
                      //     ),
                      //     SizedBox(
                      //       width: 8,
                      //     ),
                      //     Text("Problème Structurels"),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text("commentaire :",
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.w600, fontSize: 16)),
                      //     SizedBox(
                      //       height: 8,
                      //     ),
                      //     Text(
                      //       "Il est crucial de détecter rapidement les problèmes structurels afin d'assurer la sécurité et l'intégrité du bâtiment.",
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class ReceiverScreen extends StatelessWidget {
  final String typePanne;
  final String imageUrl;
  final String text;

  ReceiverScreen({
    required this.typePanne,
    required this.imageUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Receiver Screen'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Type of Panne: $typePanne',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(imageUrl)
                : Icon(Icons.image),
            SizedBox(height: 20),
            Text(
              'Commentaire: $text',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
//  CustomScrollView(
//                     slivers: [
//                       maquetteList(),
//                     ],
//                   )