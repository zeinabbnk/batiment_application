import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  var SelectedPan = null;
//fonction pour prendre les photos
  File? _photo;
//take photo function
  GetImage() async {
    try {
      final photo = await ImagePicker().getImage(source: ImageSource.camera);
      if (photo == null) return;

      final photoPermanent = await saveImage(photo.path);

      setState(() {
        this._photo = photoPermanent;
      });
    } on PlatformException catch (e) {
      print('failed to pick image : $e');
    }
    // ignore: deprecated_member_use
  }

  //save photo function

  Future<File> saveImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
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
          //taking Photo
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
          SizedBox(
            height: 30,
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: [
                "Pannes électriques",
                "Pannes de plomberie",
                "Pannes de toiture ",
                'Pannes de serrurerie',
                "Problème de peinture",
                "Problèmes d'humidité",
                "Autres"
              ],
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  icon: Icon(
                    Icons.house,
                    color: Color(0xFF2B3467),
                  ),
                  labelText: "Type de Panne",
                  labelStyle: TextStyle(
                      color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
                  hintText: "Choisir le Type de panne",
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
                  SelectedPan = val;
                });
              },
              selectedItem: SelectedPan,
            ),
          ),

          SizedBox(
            height: 30,
          ),
          //Recording Audio
          //recording timer
        ]),
      ),
    );
  }
}
