import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childname, Uint8List file) async {
    //reference objects in memory....

    Reference ref = _storage.ref().child(childname).child('images');

    //child name is the file name

    //upload file to cloud storage or remort storage.....

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData(
      {required String name,
      required String bio,
      required Uint8List file}) async {

    String resp = "some error occured";

    try{

      if(name.isNotEmpty || bio.isNotEmpty) {
        String imageUrl = await uploadImageToStorage("profile image", file);
        await _firestore.collection("userProfile").add({
          'name': name,
          'bio': bio,
          'imagelink': imageUrl
        });
        resp = "success";
      }

    }
        catch(err){

      resp= err.toString();
    }
    return resp;


  }
}
