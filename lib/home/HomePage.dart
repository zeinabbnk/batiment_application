
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List commentaires = [
    {
      "commentaire":
          "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem ",
      "image": "3.jpg"
    },
    {
      "commentaire":
          "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem",
      "image": "3.jpg"
    },
    {
      "commentaire":
          "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem ",
      "image": "3.jpg"
    },
    {
      "commentaire":
          "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem ",
      "image": "3.jpg"
    }
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(
              fontSize: 26,
              color: Color(0xFFF5EBEB),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1C6758),
        centerTitle: true,
        actions: [
          const Icon(
            Icons.house_outlined,
            size: 30,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.question_answer_outlined,
                size: 25,
              ))
        ],
        elevation: 15,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF1C6758)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color(0xFFDBDFEA),
                  child: Text(
                    "photo",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                accountName: Text("Zeinab"),
                accountEmail: Text("zaina.benkrimi43@gmail.com")),
            Card(
              color: Color(0xFFDBDFEA),
              elevation: 8,
              shadowColor: Colors.blueGrey,
              child: ListTile(
                title: Text(
                  "Home Page",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF394867),
                      fontWeight: FontWeight.w700),
                ),
                leading: Icon(
                  Icons.home,
                  size: 28,
                  color: Color(0xFF394867),
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              color: Color(0xFFDBDFEA),
              elevation: 8,
              shadowColor: Colors.blueGrey,
              child: ListTile(
                title: Text(
                  "Informations Maison",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF394867),
                      fontWeight: FontWeight.w700),
                ),
                leading: Icon(
                  Icons.person,
                  size: 28,
                  color: Color(0xFF394867),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("infohome");
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              color: Color(0xFFDBDFEA),
              elevation: 8,
              shadowColor: Colors.blueGrey,
              child: ListTile(
                title: Text(
                  "Help",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF394867),
                      fontWeight: FontWeight.w700),
                ),
                leading: Icon(
                  Icons.help_outline,
                  size: 28,
                  color: Color(0xFF394867),
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              color: Color(0xFFDBDFEA),
              elevation: 8,
              shadowColor: Colors.blueGrey,
              child: ListTile(
                title: Text(
                  "Log Out",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF394867),
                      fontWeight: FontWeight.w700),
                ),
                leading: Icon(
                  Icons.exit_to_app,
                  size: 28,
                  color: Color(0xFF394867),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addcommentaire");
        },
        backgroundColor: Color(0xFF1C6758),
        child: Icon(
          Icons.add_a_photo_outlined,
          size: 35,
        ),
      ),
      body: 
          Container(
            margin: EdgeInsets.all(9),
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, i) {
                  return ListCommentaire(
                    commentaires: commentaires[i],
                  );
                }),
          ),
      
     
    );
  }
}

class ListCommentaire extends StatelessWidget {
  const ListCommentaire({super.key, this.commentaires});
  final commentaires;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      elevation: 6,
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Image.asset(
                  "images/4.jpg",
                  fit: BoxFit.fill,
                  height: 190,
                ),
              )),
          Expanded(
              flex: 5,
              child: ListTile(
                title: Text("${commentaires['commentaire']}"),
                subtitle: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.delete,
                          color: Color(0xFF394867),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFDBDFEA),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child:
                            Icon(Icons.edit_document, color: Color(0xFF394867)),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFDBDFEA),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
