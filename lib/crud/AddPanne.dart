import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:batiment_application/home/HomePage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:microphone/microphone.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/addMaquette.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';

class AddPanne extends StatefulWidget {
  const AddPanne({super.key});

  @override
  State<AddPanne> createState() => _AddPanneState();
}

class _AddPanneState extends State<AddPanne> {
  final TextEditingController _PanneController = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  String typePanne = '';
  String Erreur = 'Veuillez Entrer les informations';

  final picker = ImagePicker();

  //take picture
  File? imageFile;
  Future<void> captureImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    if (pickedFile != null) {
      this.imageFile = File(pickedFile.path);
    }
  }

//initialisation et permission
  @override
  void initState() {
    initRecord();
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  // microphone access
  Future initRecord() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();

    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  //record audio
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  String? audioPath;

  Future starRecorder() async {
    await recorder.startRecorder(toFile: 'audio');
    setState(() {
      isRecorderReady = true;
    });
  }

  File? AudioFile;
  Future stopRecord() async {
    final filePath = await recorder.stopRecorder();

    setState(() {
      isRecorderReady = false;
      this.AudioFile = File(filePath!);
    });
  }

//formatTime
  Duration durationS = Duration.zero;
  Duration position = Duration.zero;
  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

//upload Data
  Future<void> saveDataToFirebase(
      String text, String typePanne, Uint8List imageBytes) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;

      // Upload the image to Firebase Storage
      String imageUrl = await uploadImageToStorage(storage, imageBytes);

      // Save the image URL, text, and type de panne to Firebase Firestore
      await firestore.collection('Pannes').add({
        'text': text,
        'typePanne': typePanne,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Data saved successfully
      print('Data saved to Firebase Firestore.');
    } catch (e) {
      // Error occurred while saving the data
      print('Failed to save data to Firebase Firestore: $e');
    }
  }

  Future<String> uploadImageToStorage(
      firebase_storage.FirebaseStorage storage, Uint8List imageBytes) async {
    // Generate a unique filename for the image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Create a reference to the image file in Firebase Storage
    firebase_storage.Reference ref =
        storage.ref().child('images/$fileName.jpg');

    // Upload the image file
    await ref.putData(imageBytes);

    // Get the download URL of the uploaded image
    String imageUrl = await ref.getDownloadURL();

    return imageUrl;
  }
  // void uploadData(text, imageFile, typePanne) async {
  //   if (keyForm.currentState!.validate()) {
  //     BDPanne _db = BDPanne();
  //     String _ImageURL = await _db.uploadImage(imageFile);

  //     _db.addPanne(Panne(
  //       PanneImage: _ImageURL,
  //       typePanne: typePanne,
  //       AutioText: text,
  //     ));
  //     AwesomeDialog(
  //       context: context,
  //       dialogType: DialogType.success,
  //       animType: AnimType.rightSlide,
  //       title: 'Save',
  //       desc: "Informations Saved",
  //       btnCancelOnPress: () {},
  //       btnOkOnPress: () {},
  //     )..show();
  //   }
  // }

  //Page Controller
  final _cotroller = PageController();

  //ajouter une maquette
  void showMaquette(BuildContext context) {
    AddMaquette().showMaquette(context, ImageSource.gallery);
  }

  //speechToText
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
        onTap: () => print('flutter'),
        textStyle: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        )),
    'voice': HighlightedWord(
        onTap: () => print('voice'),
        textStyle: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        )),
    'subscribe': HighlightedWord(
        onTap: () => print('subscribe'),
        textStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        )),
    'like': HighlightedWord(
        onTap: () => print('like'),
        textStyle: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        )),
    'comment': HighlightedWord(
        onTap: () => print('comment'),
        textStyle: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        )),
  };

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  // String commentaire = '';
  double _confidence = 1.0;

  //listen function
  void _Listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus :$val'),
        onError: (val) => print('onError :$val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Uint8List imageBytes = getImageBytes(); // Obtain the image bytes
          String textFieldData =
              _text; // Assuming _text holds the text field data
          String _typePanne = typePanne;
          await saveDataToFirebase(textFieldData, _typePanne,
              imageBytes); // Pass the typePanne variable
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Save',
            desc: 'Informations Saved',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          )..show();
          // uploadData(_text, imageFile, typePanne);
        },
        backgroundColor: Color(0xFF95af50),
        child: Icon(
          Icons.upload,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                      color: Color(0xFF356762),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: Column(children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xFFeaf1f3),
                            ),
                          ),
                          Text("Ajouter Une Panne",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFeaf1f3))),
                          Image.asset(
                            "images/logo.png",
                            color: Color(0xFFeaf1f3),
                            height: 50,
                            width: 50,
                          ),
                        ],
                      ),
                    )
                  ]),
                )
              ],
            ),
            Positioned(
              top: 120,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFeaf1f3),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 6.0,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                    ),
                    height: 600,
                    width: 360,
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: PageView(controller: _cotroller, children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 95),
                        decoration: BoxDecoration(
                          color: Color(0xFFC2DED1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 50),
                              child: Icon(
                                Icons.library_add_rounded,
                                size: 80,
                                color: Color(0xFFeaf1f3),
                              ),
                            ),
                            Text(
                              "Ajouter Maquette",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 60),
                              child: ElevatedButton(
                                onPressed: () => showMaquette(context),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.upload_file_rounded),
                                    Text(
                                      "Ajouter",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF356762),
                                  shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 95),
                        decoration: BoxDecoration(
                          color: Color(0xFFC2DED1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Ajouter une Photo",
                              style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //take Picture
                            imageFile != null
                                ? Image.file(
                                    imageFile!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'images/4.png',
                                    height: 150,
                                    width: 200,
                                    color: Color(0xFFedf4f4),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 60),
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () => captureImageFromCamera(),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo,
                                      size: 25,
                                      // color: Color(0xFF2B3467),
                                    ),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    Text(
                                      'Take Picture',
                                      style: TextStyle(
                                          fontSize: 15,
                                          // color: Color(0xFF2B3467),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF356762),
                                  shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15, bottom: 15),
                              child: Form(
                                key: keyForm,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: TextFormField(
                                    // controller: _PanneController,
                                    cursorColor: Color(0xFFedf4f4),
                                    decoration: InputDecoration(
                                      hintMaxLines: 1,
                                      labelText: "Type de Panne",
                                      labelStyle: TextStyle(
                                          color: Color(0xFF2B3467),
                                          fontWeight: FontWeight.bold),
                                      prefixIcon: Icon(Icons.roofing,
                                          color: Color(0xFF2B3467)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFFedf4f4),
                                              width: 3)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFFedf4f4),
                                              width: 3)),
                                    ),
                                    onChanged: (value) => typePanne = value,
                                    validator: (value) =>
                                        typePanne == '|' ? Erreur : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 95),
                        decoration: BoxDecoration(
                          color: Color(0xFFC2DED1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Recorder un Audio",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 26),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SingleChildScrollView(
                                reverse: true,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 80),
                                  child: TextHighlight(
                                    text: _isListening
                                        ? _text
                                        : "Press the button and start speaking",
                                    words: _highlights,
                                    textStyle: const TextStyle(
                                      fontSize: 20.0,
                                      color: Color(0xFF356762),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    _Listen();
                                  },
                                  child: AvatarGlow(
                                    animate: _isListening,
                                    glowColor: Color(0xFF356762),
                                    endRadius: 75.0,
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    repeatPauseDuration:
                                        const Duration(milliseconds: 100),
                                    repeat: true,
                                    child: Icon(
                                        _isListening
                                            ? Icons.mic
                                            : Icons.mic_none,
                                        color: Color.fromARGB(255, 8, 51, 10)),
                                  ),
                                ),
                              ),
                            ]),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SmoothPageIndicator(
                    controller: _cotroller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Color(0xFFC2DED1),
                      dotColor: Color(0xFFeaf1f3).withOpacity(0.5),
                      dotHeight: 20,
                      dotWidth: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Uint8List getImageBytes() {
  return Uint8List(0);
}
