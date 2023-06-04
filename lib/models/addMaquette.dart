import 'dart:io';

import 'package:batiment_application/models/maquetteModel.dart';
import 'package:batiment_application/service/dataService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMaquette {
  void showMaquette(BuildContext context, ImageSource source) async {
    XFile? _pickerFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickerFile!.path);

    if (_file == null) return;
    final _keyForm = GlobalKey<FormState>();
    String _NumE = '';
    String _titre = '';
    String _Erreur = 'Veuillez Entrer les informations';

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xFFDBDFEA),
                    image: DecorationImage(
                        image: FileImage(_file), fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Form(
                        key: _keyForm,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: TextFormField(
                                // controller: NumEController,
                                cursorColor: Color(0xFFBAD7E9),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintMaxLines: 1,
                                  labelText: "Numéro d'étage",
                                  labelStyle: TextStyle(
                                      color: Color(0xFF2B3467),
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(Icons.roofing,
                                      color: Color(0xFF2B3467)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(0xFFedf4f4), width: 3)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(0xFFedf4f4), width: 3)),
                                ),
                                onChanged: (value) => _NumE = value,
                                validator: (value) =>
                                    _NumE == '|' ? _Erreur : null,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                // controller: TitreController,
                                cursorColor: Color(0xFFBAD7E9),
                                decoration: InputDecoration(
                                  hintMaxLines: 1,
                                  labelText: "Titre",
                                  labelStyle: TextStyle(
                                      color: Color(0xFF2B3467),
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(Icons.title,
                                      color: Color(0xFF2B3467)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(0xFFedf4f4), width: 3)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(0xFFedf4f4), width: 3)),
                                ),
                                onChanged: (value) => _titre = value,
                                validator: (value) =>
                                    _titre == '|' ? _Erreur : null,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Wrap(
                  children: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Annuler",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF95af50)),
                        )),
                    Container(
                      margin: EdgeInsets.only(right: 9, bottom: 5),
                      child: ElevatedButton(
                        onPressed: () =>
                            _onSubmit(context, _keyForm, _file, _titre, _NumE),
                        child: Text(
                          "Suivant",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF95af50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  //enregister les données de la maquette
  void _onSubmit(context, _keyForm, file, titre, NumE) async {
    if (_keyForm.currentState!.validate()) {
      Navigator.of(context).pop();
      DBMaquette db = DBMaquette();
      String _MaqURLImage = await db.uploadMaquette(file);
      db.addMaquette(Maquette(
        titre: titre,
        NumE: NumE,
        MaqURLImage: _MaqURLImage,
      ));
    }
  }
}
