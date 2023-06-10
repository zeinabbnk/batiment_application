import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:batiment_application/crud/infos.dart';
import 'package:batiment_application/crud/rapportScreen.dart';
import 'package:batiment_application/home/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth/login_page.dart';

class ScreenDrawer extends StatefulWidget {
  const ScreenDrawer({super.key});

  @override
  State<ScreenDrawer> createState() => _ScreenDrawerState();
}

class _ScreenDrawerState extends State<ScreenDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF356762),
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(children: <Widget>[
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF356762),
                child: ClipRect(
                    child: Image(
                  image: AssetImage("images/logo.png"),
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                  color: Colors.white,
                )),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Expert Eye",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 90,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Color(0xFF9fbdc2),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Profil",
                      style: TextStyle(
                          color: Color(0xFF9fbdc2),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => infoHome()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add_home_outlined,
                      color: Color(0xFF9fbdc2),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Add Home",
                      style: TextStyle(
                          color: Color(0xFF9fbdc2),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.home_filled,
                      color: Color(0xFF9fbdc2),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Home Page",
                      style: TextStyle(
                          color: Color(0xFF9fbdc2),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          SizedBox(
            height: 210,
          ),
          InkWell(
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                title: 'Are You Sure',
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                },
              )..show();
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.cancel_outlined,
                  color: Color(0xFF9fbdc2),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Log Out",
                  style: TextStyle(
                      color: Color(0xFF9fbdc2), fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class Elements extends StatelessWidget {
  final IconData icon;
  final String text;

  const Elements({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Color(0xFF9fbdc2),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(
                color: Color(0xFF9fbdc2), fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
