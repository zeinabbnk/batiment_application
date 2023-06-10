import 'package:batiment_application/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;

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
              margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              elevation: 5,
              shadowColor: const Color(0xFFF6F1F1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/logo.png",
                    height: 120,
                    width: 300,
                    color: Color(0xFF394867),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Email :",
                          labelStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF394867)),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Color(0xFFedf4f4),
                            size: 25,
                          ),
                          hintText: "Enter_Email",
                          hintStyle:
                              TextStyle(fontSize: 12, color: Color(0xFFF6F1F1)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF394867), width: 3)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF394867), width: 3))),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: passwordController,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                          labelText: "PassWord :",
                          labelStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF394867)),
                          prefixIcon: Icon(
                            Icons.password,
                            color: Color(0xFFedf4f4),
                            size: 25,
                          ),
                          hintText: "Enter_Pass_Word",
                          hintStyle:
                              TextStyle(fontSize: 12, color: Color(0xFFF6F1F1)),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(
                              passToggle
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xFF394867),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF394867), width: 3)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF394867), width: 3))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF356762),
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim());
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFedf4f4),
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text("Have an Account", style: TextStyle(fontWeight: FontWeight.w600),),
                  )
                ],
              ),
            )));
  }
}
