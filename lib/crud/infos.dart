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
        backgroundColor: Color(0xFF2B3467),
        title: Row(
          children: [
            Icon(
              Icons.insert_drive_file_outlined,
              size: 33,
              color: Color(0xFFFCFFE7),
            ),
            Text(
              "House Informations",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFCFFE7)),
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
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                labelText: "adress ",
                icon: Icon(Icons.location_city, color: Color(0xFF2B3467)),
                labelStyle: TextStyle(
                    color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.house,
                  color: Color(0xFF2B3467),
                  size: 25,
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(),
                  child: DropdownSearch<String>(
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
                        labelText: "Type de Batiment",
                        hintText: "Choisir un Type de Batiment",
                      ),
                    ),
                    onChanged: print,
                    selectedItem: SelectedItem,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3),
                ),
                labelText: "Nombre d etages ",
                icon: Icon(Icons.stairs, color: Color(0xFF2B3467)),
                labelStyle: TextStyle(
                    color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
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
