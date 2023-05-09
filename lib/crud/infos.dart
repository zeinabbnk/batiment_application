import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class infoHome extends StatefulWidget {
  const infoHome({super.key});

  @override
  State<infoHome> createState() => _infoHomeState();
}

class _infoHomeState extends State<infoHome> {
  var SelectedItem = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBAD7E9),
        title: Row(
          children: [
            Icon(
              Icons.insert_drive_file_outlined,
              size: 33,  
            ),
            SizedBox(width: 10,),
            
            Text(
              "House Informations",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                 ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 45),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                labelText: "Adress ",
                icon: Icon(Icons.location_city, color: Color(0xFF2B3467)),
                labelStyle: TextStyle(
                    color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            DropdownSearch<String>(
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: [
                "Duplex",
                "Appartement",
                "Maison",
                'Villa',
                "Garçonnière"
              ],
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  icon: Icon(
                    Icons.house,
                    color: Color(0xFF2B3467),
                  ),
                  labelText: "Type de Batiment",
                  labelStyle: TextStyle(
                      color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
                  hintText: "Choisir un Type de Batiment",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: Color(0xFFBAD7E9), width: 3)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                  ),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  SelectedItem = val;
                });
              },
              selectedItem: SelectedItem,
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                labelText: "Nombre d'étages ",
                icon: Icon(Icons.stairs, color: Color(0xFF2B3467)),
                labelStyle: TextStyle(
                    color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 180,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("addMaquette");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload_file_outlined,
                      color: Color(0xFF2B3467),
                      size: 26,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Commencer",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2B3467)),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFEB455F),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
