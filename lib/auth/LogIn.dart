import 'package:batiment_application/service/authService.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool inLoginProcess = false;

  signin() {
    setState(() {
      inLoginProcess = true;
      AuthService().signInWithGoogle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("images/1.png"),
        fit: BoxFit.cover,
      )),
      child: Card(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(vertical: 150, horizontal: 40),
        elevation: 5,
        shadowColor: const Color(0xFFF6F1F1),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/logo.png",
                height: 180,
                width: 350,
                color: Color(0xFF394867),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Expert Eye",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF394867),
                    shadows: [
                      Shadow(
                          color: Color(0xFFF6F1F1),
                          blurRadius: 25,
                          offset: Offset(0, 15))
                    ]),
              ),
              SizedBox(
                height: 40,
              ),
              inLoginProcess
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () => signin(),
                      child: Text(
                        "Connectez-vous avec Google",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF212A3E),
                            fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFFF1F6F9),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
