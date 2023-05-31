import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xoffset = 0;
  double yoffset = 0;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xoffset, yoffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Color(0xFFeaf1f3),
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
                        child: Icon(Icons.arrow_back_ios),
                        onTap: () {
                          setState(() {
                            xoffset = 0;
                            yoffset = 0;
                            isDrawerOpen = false;
                          });
                        },
                      )
                    : GestureDetector(
                        child: Icon(Icons.menu),
                        onTap: () {
                          setState(() {
                            xoffset = 300;
                            yoffset = 80;
                            isDrawerOpen = true;
                          });
                        },
                      ),
                SizedBox(
                  width: 100,
                ),
                Text(
                  "Home Page",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xFFeaf1f3),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 0))
                ]),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cardExemple(text: "Consultez ", icon: Icons.edit_document),
                  cardExemple(text: "Consultez ", icon: Icons.edit_document),
                  cardExemple(text: "Consultez ", icon: Icons.edit_document),
                  cardExemple(text: "Consultez ", icon: Icons.edit_document),
                  cardExemple(text: "Consultez ", icon: Icons.edit_document),
                ]),
          )
        ]),
      ),
    );
  }
}

class cardExemple extends StatelessWidget {
  final String text;
  final IconData icon;

  const cardExemple({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Icon(icon),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      ),
    );
  }
}
