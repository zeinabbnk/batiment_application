import 'dart:ffi';

import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  String _email ='';
  String _password ='';

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
        margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 50),
        elevation: 5,
        shadowColor: const Color(0xFFF6F1F1),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "images/2.png",
                  height: 120,
                  width: 200,
                  color: Color(0xFF394867),
                ),
                Form(
                  key: _formField,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: "User Email :",
                            labelStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF394867)),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Color(0xFF394867),
                            ),
                            hintText: "Enter_Email",
                            hintStyle: TextStyle(
                                fontSize: 12, color: Color(0xFFF6F1F1)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF394867), width: 3)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF394867), width: 3))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email";
                          }
                          bool emailValid = RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value);
                          if (!emailValid) {
                            return "Enter Valid Email";
                          }
                          return null;
                        },
                        onChanged: (val) => _email = val,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: passToggle,
                        controller: passController,
                        decoration: InputDecoration(
                            labelText: "Pass Word :",
                            labelStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF394867)),
                            prefixIcon: Icon(
                              Icons.password,
                              color: Color(0xFF394867),
                            ),
                            suffixIcon: InkWell(
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
                            hintText: "Enter_Pass_Word",
                            hintStyle: TextStyle(
                                fontSize: 12, color: Color(0xFFF6F1F1)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF394867), width: 3)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF394867), width: 3))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your PassWord";
                          } else if (passController.text.length < 6) {
                            return "PassWord should have more than 6 characters";
                          }
                          return null;
                        },
                        onChanged: (val) => _password = val,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(children: [
                    Text("if you haven't an account"),
                    SizedBox(
                      width: 3,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("signup");
                      },
                      child: Text(
                        "Click here",
                        style: TextStyle(
                            color: Color(0xFF87CBB9),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ]),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("IntroPage");
                    if (_formField.currentState!.validate()) {
                      
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF212A3E),
                        fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF1F6F9),
                      padding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 25),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
