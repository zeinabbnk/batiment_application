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
        backgroundColor: Color(0xFF1C6758),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  height: 170,
                  width: 300,
                  color: Color(0xFF394867),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  GetImage();
                },
                child: Row(
                  children: [
                    Icon(Icons.camera, color: Color(0xFFF6F1F1)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Camera",
                      style: TextStyle(
                          color: Color(0xFFF6F1F1),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF1C6758),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 8,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  PhotoPick();
                },
                child: Row(
                  children: [
                    Icon(Icons.image_outlined, color: Color(0xFFF6F1F1)),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Gallery",
                        style: TextStyle(
                            color: Color(0xFFF6F1F1),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF1C6758),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 8,
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              minLines: 1,
              maxLines: 20,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF1F6F9),
                prefixIcon: Icon(
                  Icons.note_add_outlined,
                  color: Color(0xFF394867),
                ),
                labelText: "Commentaire :",
                labelStyle: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF394867),
                    fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  borderSide: BorderSide(color: Color(0xFF394867), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  borderSide: BorderSide(color: Color(0xFF394867), width: 2),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: 190,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF1C6758),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.note_add_outlined, color: Color(0xFFF6F1F1)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Add Comment",
                    style: TextStyle(
                        color: Color(0xFFF6F1F1), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
