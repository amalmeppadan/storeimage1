import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storeimage1/add_data.dart';
import 'package:storeimage1/utils.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Uint8List? _image;
  TextEditingController namectrl = TextEditingController();
  TextEditingController bioctrl = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  // save profile pic..............

  void saveProfile()async{

    String name = namectrl.text;
    String bio = bioctrl.text;

    String resp = await StoreData().saveData(name: name, bio: bio, file: _image!);



  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 24,
            ),
            Stack(
              children: <Widget>[
                _image != null
                    ? CircleAvatar(
                  radius: 64,
                  backgroundImage: MemoryImage(_image!),
                )
                    : const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      "https://png.pngtree.com/png-vector/20191125/ourmid/pngtree-beautiful-profile-line-vector-icon-png-image_2035279.jpg"),
                ),
                Positioned(
                  child: IconButton(
                      onPressed: selectImage, icon: Icon(Icons.add_a_photo)),
                  bottom: 2,
                  left: 90,
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: namectrl,
              decoration: InputDecoration(
                  hintText: "enter name",
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: bioctrl,
              decoration: InputDecoration(
                  hintText: "enter Bio",
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(onPressed:saveProfile, child: Text(" save profile"))
          ]),
        ),
      ),
    );
  }
}
