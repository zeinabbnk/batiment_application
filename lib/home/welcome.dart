import 'package:flutter/material.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("homepage");
        },
        backgroundColor: Color(0xFF95af50),
        child: Icon(
          Icons.navigate_next_outlined,
          size: 50,
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/5.jpg"),
          fit: BoxFit.fill,
        )),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 80),
              child: Image.asset(
                "images/logo.png",
                height: 150,
                color: Color(0xFF0356762),
              ),
            ),
            Text(
              "Let's Us Guide You",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFedf4f4)),
            )
          ],
        ),
      ),
    );
  }
}
