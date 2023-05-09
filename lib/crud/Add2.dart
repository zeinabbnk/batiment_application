import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  File? _photo;

  GetImage() async {
    // ignore: deprecated_member_use
    final photo = await ImagePicker().getImage(source: ImageSource.camera);
    if (photo == null) return;

    setState(() {
      this._photo = File(photo.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBAD7E9),
        title: Text(
          "Add Image",
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
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: Column(children: [
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
            height: 30,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 100),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                GetImage();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.camera,
                    color: Color(0xFF2B3467),
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Take a Picture",
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
        ]),
      ),
    );
  }
}
