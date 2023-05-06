import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
        margin: const EdgeInsets.symmetric(vertical: 85, horizontal: 50),
        elevation: 5,
        shadowColor: const Color(0xFFF6F1F1),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "images/2.png",
                height: 120,
                width: 200,
                color: Color(0xFF394867),
              ),
              const TextField(
                decoration: InputDecoration(
                    labelText: "User Name :",
                    labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF394867)),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF394867),
                    ),
                    hintText: "Enter_User_Name",
                    hintStyle:
                        TextStyle(fontSize: 12, color: Color(0xFFF6F1F1)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF394867), width: 3)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF394867), width: 3))),
              ),
              const TextField(
                obscureText: true,
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
                    hintText: "Enter_Pass_Word",
                    hintStyle:
                        TextStyle(fontSize: 12, color: Color(0xFFF6F1F1)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF394867), width: 3)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF394867), width: 3))),
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
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("homepage");
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
              )
            ],
          ),
        ),
      ),
    ));
  }
}
