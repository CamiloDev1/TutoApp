import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class create_news extends StatefulWidget {
  @override
  State<create_news> createState() => _create_newsState();
}

class _create_newsState extends State<create_news> {
  final cloudinary = CloudinaryPublic('deqjapy1y', 'xb4flnov', cache: false);

  File? _image;
  _imgFromCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  TextEditingController myController_title = TextEditingController();
  TextEditingController myController_description = TextEditingController();
  @override
  void dispose() {
    myController_title.dispose();
    myController_description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Publicar noticia")),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          const SizedBox(
            height: 52,
          ),
          Text("Agrega una imagen a la publicacion"),
          const SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: const Color(0xffFDCF09),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(25.0)),
          TextField(
            controller: myController_title,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Titulo',
            ),
          ),
          Padding(padding: EdgeInsets.all(25.0)),
          TextField(
            controller: myController_description,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descripción',
            ),
          ),
          Padding(padding: EdgeInsets.all(25.0)),
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Color.fromARGB(255, 64, 118, 161)
                          .withOpacity(0.04);
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed))
                      return Colors.blue.withOpacity(0.12);
                    return null; // Defer to the widget's default.
                  },
                ),
              ),
              onPressed: () async {
                AlertDialog(
                  title: Text("Campo vacio"),
                  actions: [
                    FloatingActionButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cerrar"),
                    )
                  ],
                );
                print(_image.toString());
                print("Pulso boton publicar");
                var titleStr = myController_title.text.toString();
                var descriptionStr = myController_description.text.toString();
                // DateTime date = DateTime(DateTime.now().year,
                //     DateTime.now().month, DateTime.now().day);

                DateTime now = DateTime.now();
                String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                var type = 1;

                if (titleStr == null || descriptionStr == null) {
                  AlertDialog(
                    title: Text("Campo vacio"),
                    actions: [
                      FloatingActionButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cerrar"),
                      )
                    ],
                  );
                } else {
                  try {
                    print("Subiendo");
                    CloudinaryResponse response = await cloudinary.uploadFile(
                      CloudinaryFile.fromFile(_image!.path,
                          resourceType: CloudinaryResourceType.Image),
                    );

                    print(response.secureUrl);
                    add(titleStr, descriptionStr, response.secureUrl,
                        formattedDate.toString(), type.toString());
                  } on CloudinaryException catch (e) {
                    print(e.message);
                    print(e.request);
                    Center(child: Text("No su pudo cargar la imagen"));
                  }
                }
                print("/" + formattedDate.toString() + "/");
              },
              child: Text('Publicar'))
        ]),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  add(String title, String description, String image_link, String date,
      String type) async {
    final http.Response response = await http.post(
      'http://13.56.20.66:5002/notices',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'description': description,
        'image': image_link,
        'date': date,
        'type': type
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      Navigator.pushNamed(context, '/main_teachers');
    } else {
      throw Exception('Failed to get question paper.');
    }
  }
}
