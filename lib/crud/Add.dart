import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddCmt extends StatefulWidget {
  const AddCmt({super.key});

  @override
  State<AddCmt> createState() => _AddCmtState();
}

class _AddCmtState extends State<AddCmt> {
  File? _photo;

  GetImage() async {
    // ignore: deprecated_member_use
    final photo = await ImagePicker().getImage(source: ImageSource.camera);
    if (photo == null) return;

    setState(() {
      this._photo = File(photo.path);
    });
  }

  PhotoPick() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) return;

    final photoTemporary = File(photo.path);

    setState(() {});
    this._photo = photoTemporary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBAD7E9),
        title: Text(
          "Add Document",
          style: TextStyle(fontSize: 26, color: Color(0xFFF6F1F1)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.help_outlined),
            color: Color(0xFFF6F1F1),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.photo),
              color: Color(0xFFF6F1F1))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            _photo != null
                ? Image.file(
                    _photo!,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "images/4.png",
                    height: 150,
                    width: 200,
                    color: Color(0xFF2B3467),
                  ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 100),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  PhotoPick();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.upload_file_outlined,
                      color: Color(0xFF2B3467),
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Upload Maquette",
                      style: TextStyle(
                          fontSize: 15,
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
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: TextField(
                cursorColor: Color(0xFFBAD7E9),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintMaxLines: 1,
                  labelText: "Numéro d'étage",
                  labelStyle: TextStyle(
                      color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.roofing, color: Color(0xFF2B3467)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xFFBAD7E9), width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xFFBAD7E9), width: 3)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                cursorColor: Color(0xFFBAD7E9),
                decoration: InputDecoration(
                  hintMaxLines: 1,
                  labelText: "Titre",
                  labelStyle: TextStyle(
                      color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.title, color: Color(0xFF2B3467)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xFFBAD7E9), width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xFFBAD7E9), width: 3)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 120),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.skip_next,
                      color: Color(0xFF2B3467),
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Suivant",
                      style: TextStyle(
                          fontSize: 15,
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
            ),
          ],
        ),
      ),
    );
  }
}
