import 'package:batiment_application/models/panneModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BDPanne {
//initialisation et déclaration
  CollectionReference _panne = FirebaseFirestore.instance.collection('transcription');
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(imageUrl) async {
    // Upload the image file
    Reference imageReference =
        _storage.ref().child('panne/images/${DateTime.now()}.png');
    UploadTask imageUploadTask = imageReference.putFile(imageUrl);
    TaskSnapshot imageSnapshot = await imageUploadTask;
    return await imageSnapshot.ref.getDownloadURL();
  }

  // Future<String> uploadAudio(audioFile) async {
  //   // Upload the audio file
  //   Reference audioReference =
  //       _storage.ref().child('panne/audio/${DateTime.now()}.mp3');
  //   UploadTask audioUploadTask = audioReference.putFile(audioFile);
  //   TaskSnapshot audioSnapshot = await audioUploadTask;
  //   return await audioSnapshot.ref.getDownloadURL();
  // }
  
  

  //add panne
  void addPanne(Panne panne) {
    _panne.add({
      "typePanne": panne.typePanne,
      "imageUrl": panne.PanneImage,
         

    
     
    });
  }
}

//  UploadTask audioUploadTask = audioReference.putFile(File(audioFilePath));
//     TaskSnapshot audioSnapshot = await audioUploadTask;

//     // Get the download URL for the audio file
//     String audioDownloadURL = await audioSnapshot.ref.getDownloadURL();