import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmailPassSignInScreen extends StatefulWidget {
  const EmailPassSignInScreen({Key? key}) : super(key: key);

  @override
  State<EmailPassSignInScreen> createState() => _EmailPassSignInScreenState();
}

class _EmailPassSignInScreenState extends State<EmailPassSignInScreen> {
  final ImagePicker _picker = ImagePicker();
  final storage = FirebaseStorage.instance;

  XFile? image;
  // List<XFile>? images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              pickImage();
            },
            child: Container(
              height: 200,
              color: Colors.greenAccent,
              child: image == null
                  ? const SizedBox()
                  : Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          // for multiple image
          // ElevatedButton(
          //   onPressed: () {
          //     pickImage();
          //   },
          //   child: Container(
          //     height: 200,
          //     color: Colors.greenAccent,
          //     child: images == null
          //         ? const SizedBox()
          //         : ListView.builder(
          //             scrollDirection: Axis.horizontal,
          //             itemCount: images!.length,
          //             itemBuilder: (BuildContext context, int index) {
          //               return Image.file(
          //                 File(images![index].path),
          //                 fit: BoxFit.cover,
          //               );
          //             },
          //           ),
          //   ),
          // ),

          ElevatedButton(
            onPressed: () {
              sendFile();
            },
            child: const Text("SendFile"),
          ),
          ElevatedButton(
            onPressed: () {
              uploadImage();
            },
            child: const Text("UploadImage"),
          ),
        ],
      ),
    );
  }

  pickImage() async {
    // Capture a photo
    image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  sendFile() async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final janki = storageRef.child("janki.jpg");
      await janki.putFile(File(image!.path));
    } catch (e) {
      debugPrint("Error ------------>>> $e ");
    }
  }

  uploadImage() async {
    try {
      File file = File(image!.path);
      storage.ref().child('images/janki.jpg').putFile(file);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // for multiple image
  // pickImage() async {
  //   // Capture photos
  //   images = await _picker.pickMultiImage();
  //   setState(() {});
  // }
  //
  // sendFile() async {
  //   try {
  //     final storageRef = FirebaseStorage.instance.ref();
  //     for (var i = 0; i < images!.length; i++) {
  //       final janki = storageRef.child("images_$i.jpg");
  //       await janki.putFile(File(images![i++].path));
  //     }
  //   } catch (e) {
  //     debugPrint("Error ------------>>> $e");
  //   }
  // }
  //
  // uploadImage() async {
  //   try {
  //     for (var i = 0; i < images!.length; i++) {
  //       File file = File(images![i++].path);
  //       storage.ref().child('images/images_$i.jpg').putFile(file);
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
