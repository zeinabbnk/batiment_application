import 'dart:io';

import 'package:batiment_application/models/addMaquette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  var SelectedPan = null;

//upload Image to FireBase Storage
  void uploadImage() async {
    PickedFile? pickerFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    File fileImage = File(pickerFile!.path);
  }

  //type de pannes
  final keyForm = GlobalKey<FormState>();
  String typePanne = '';
  String Erreur = 'Veuillez Entrer les informations';

//fonctions pour enregister audio
  @override
  void initState() {
    initRecord();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

//recording/playing audio Variable
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  String? audioPath;
  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;
  Duration durationS = Duration.zero;
  Duration position = Duration.zero;

//formatTime
  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
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

  //2 functions for starting record an stop
  Future starRecorder() async {
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stopRecord() async {
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    print('Recorder file path is : $file');
  }

  //ajouter une maquette
  void showMaquette(BuildContext context) {
    AddMaquette().showMaquette(context, ImageSource.gallery);
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
              onPressed: () => showMaquette(context),
              icon: Icon(
                Icons.photo,
                size: 30,
              ),
              color: Color(0xFFF6F1F1))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color(0xFFF1F6F9),
          child: Icon(
            Icons.add_a_photo_outlined,
            size: 30,
            color: Color(0xFF394867),
          )),
      body: Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: Column(children: [
          //taking Photo
          // _photo != null
          //     ? Image.file(
          //         _photo!,
          //         width: 250,
          //         height: 250,
          //         fit: BoxFit.cover,
          //       )
          //     :
          Image.asset(
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
                // GetImage();
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

          Form(
            key: keyForm,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                // controller: NumEController,
                cursorColor: Color(0xFFBAD7E9),
                decoration: InputDecoration(
                  hintMaxLines: 1,
                  labelText: "Type de Panne",
                  labelStyle: TextStyle(
                      color: Color(0xFF2B3467), fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.roofing, color: Color(0xFF2B3467)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFBAD7E9), width: 3)),
                ),
                onChanged: (value) => typePanne = value,
                validator: (value) => typePanne == '|' ? Erreur : null,
              ),
            ),
          ),

          SizedBox(
            height: 30,
          ),
          //Recording Audio
          //recording timer
          StreamBuilder<RecordingDisposition>(
            builder: (context, snapshot) {
              final duration =
                  snapshot.hasData ? snapshot.data!.duration : Duration.zero;

              String twoDigits(int n) => n.toString().padLeft(2, '0');
              final twoDigitsMinites =
                  twoDigits(duration.inMinutes.remainder(60));
              final twoDigitsSeconds =
                  twoDigits(duration.inSeconds.remainder(60));

              return Text(
                "$twoDigitsMinites : $twoDigitsSeconds",
                style: TextStyle(
                    color: Color(0xFF2B3467),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              );
            },
            //updating the recording
            stream: recorder.onProgress,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 180,
            height: 85,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                if (recorder.isRecording) {
                  await stopRecord();
                  setState(() {});
                } else {
                  await starRecorder();
                  setState(() {});
                }
              },
              child:
                  //record Button
                  Row(
                children: [
                  Icon(recorder.isRecording ? Icons.stop : Icons.mic_outlined,
                      size: 28, color: Color(0xFF2B3467)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    recorder.isRecording ? "Stop" : "Record",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B3467)),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFFDBDFEA),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ]),
      ),
    );
  }
}
