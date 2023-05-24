import 'package:batiment_application/models/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('House');

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
}
