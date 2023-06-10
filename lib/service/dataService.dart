import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/maquetteModel.dart';

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
      "Time": FieldValue.serverTimestamp(),
    });
  }

//récupération des maquette
  Stream<List<Maquette>> get Maquettes {
    Query queryMaquette = _maquette.orderBy('Time', descending: true);
    return queryMaquette.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Maquette(
          MaquetteId: doc.id,
          titre: doc.get('Titre'),
          NumE: doc.get('NumEtage'),
          MaqURLImage: doc.get('Maquette'),
        );
      }).toList();
    });
  }
}
