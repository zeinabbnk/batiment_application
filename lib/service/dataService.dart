import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/maquetteModel.dart';
import '../models/panneModel.dart';

class DBMaquette {
//déclaration et initialisation de la maquette
  CollectionReference _maquette =
      FirebaseFirestore.instance.collection('maquettes');
  FirebaseStorage _storage = FirebaseStorage.instance;

//upload photo from Gallery to firebase function
  Future<String> uploadMaquette(file) async {
    Reference reference =
        _storage.ref().child('maquettes/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

//add maquette to the db function
  void addMaquette(Maquette maq) {
    _maquette.add({
      "Titre": maq.titre,
      "NumEtage": maq.NumE,
      "Maquette": maq.MaqURLImage,
      "MaquetteId": maq.MaquetteId,
    });
  }

//déclaration et initialisation de panne
  CollectionReference _pannes = FirebaseFirestore.instance.collection('pannes');
  FirebaseStorage panneStorage = FirebaseStorage.instance;

  //upload photo from camera to firebase function
  Future<String> uploadPanne(imageFile) async {
    Reference _reference =
        panneStorage.ref().child('panne/${DateTime.now()}.png');
    UploadTask _uploadTask = _reference.putFile(imageFile);
    TaskSnapshot _taskSnapshot = await _uploadTask;
    return await _taskSnapshot.ref.getDownloadURL();
  }

  //upload 

//Ajout d'une pannes
void addPanne(Panne panne){}

}


