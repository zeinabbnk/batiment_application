import 'dart:ffi';
import 'dart:typed_data';

import 'package:batiment_application/models/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('House');
final CollectionReference _pannes =
    _collection.doc('HousePanne').collection("pannes");

class FireBaseCRUD {
  //ajouter les infos d'un bâtiment
  static Future<Response> addHouse({
    required String Adress,
    required String TypeBatiment,
    required String NumEtage,
  }) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "Adesse": Adress,
      "Type Bâtiment": TypeBatiment,
      "Numéro étage": NumEtage,
    };

    var resultat = await documentReference.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully Added to the DataBase";
    }).catchError((e) {
      response.code = 500;
      response.message = e.message;
    });
    return response;
  }

  //read data
  static Stream<QuerySnapshot> showHouse() {
    CollectionReference houseItemCollection = _collection;
    return houseItemCollection.snapshots();
  }

  //delete data
  static Future<Response> deleteHouse({
    required String HouseID,
  }) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc(HouseID);

    await documentReference.delete().whenComplete(() {
      response.code = 200;
      response.message = "Successfully Deleted House";
    }).catchError((e) {
      response.code = 500;
      response.message = e.message;
    });
    return response;
  }

  Future<void> saveDataToFirebase(
      String text, String typePanne, Uint8List imageBytes) async {
    try {
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;

      // Upload the image to Firebase Storage
      String imageUrl = await uploadImageToStorage(storage, imageBytes);

      // Save the image URL, text, and type de panne to Firebase Firestore
      _pannes.add({
        'text': text,
        'typePanne': typePanne,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Error occurred while saving the data
      print('Failed to save data to Firebase Firestore: $e');
    }
  }

  //affichage des données
  static Stream<QuerySnapshot> showPanne() {
    CollectionReference panneItemCollection = _pannes;
    return panneItemCollection.snapshots();
  }
}

Future<String> uploadImageToStorage(
    firebase_storage.FirebaseStorage storage, Uint8List imageBytes) async {
  // Generate a unique filename for the image
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();

  // Create a reference to the image file in Firebase Storage
  firebase_storage.Reference ref = storage.ref().child('images/$fileName.jpg');

  // Upload the image file
  await ref.putData(imageBytes);

  // Get the download URL of the uploaded image
  String imageUrl = await ref.getDownloadURL();

  return imageUrl;
}
