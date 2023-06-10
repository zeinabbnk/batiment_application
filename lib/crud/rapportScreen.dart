import 'package:batiment_application/crud/report.dart';
import 'package:batiment_application/models/maquetteList.dart';
import 'package:flutter/material.dart';

class screenRapport extends StatelessWidget {
  const screenRapport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF95af50),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Rapport()),
            (Route<dynamic> route) => false,
          );
        },
        child: Icon(
          Icons.arrow_back,
          size: 30,
        ),
      ),
      body: SafeArea(
          child: Stack(children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
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
                      Text("Maquettes",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFeaf1f3))),
                              SizedBox(width: 80,),
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
        CustomScrollView(
          slivers: [
            maquetteList(),
          ],
        ),
      ])),
    );
  }
}
