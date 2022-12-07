import 'dart:convert';
import 'dart:ffi';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuto_app/models/teacher.dart';
import 'package:http/http.dart' as http;
import '../models/Profile_loged.dart';
import '../models/Data.dart';

class List_teachers extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<List_teachers> createState() => _List_teachersState();
}

class _List_teachersState extends State<List_teachers> {
  void _getdataprofile() {}
  late Future<List<teachers>> _listOfTeachers;
  List<teachers> teacher = [];

  Future<List<teachers>> _getTeachers() async {
    final response = await http.get("http://52.53.171.98:5000/docentes");

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);
      print(jsonData);
      for (var element in jsonData) {
        teacher.add(teachers(element["_id"].toString(), element["name"],
            element["password"], element["rol"], element["correo"]));
      }

      return teacher;
    } else {
      throw Exception("Fail connection.");
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _listOfTeachers = _getTeachers();
  }

  @override
  Widget build(BuildContext context) {
    Data argumento = ModalRoute.of(context)!.settings.arguments as Data;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Seleccionar profesor",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: _listOfTeachers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                  itemCount: teacher.length,
                  itemBuilder: ((context, index) {
                    return Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(5),
                            ),
                            Card(
                              color: Color.fromARGB(255, 235, 232, 232),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      Icons.person_pin,
                                      size: 50,
                                      color: Color.fromARGB(255, 0, 170, 248),
                                    ),
                                    title: Center(
                                        child: Text(
                                      teacher[index].name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'Enviar solicitud',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        onPressed: () async {
                                          print(argumento.materia);
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          String name =
                                              await prefs.getString('name');
                                          String correo = await prefs
                                              .getString('matricula');
                                          print(name);
                                          print(correo);
                                          // print(datosDeLogeo.name);
                                          // print(datosDeLogeo.correo);
                                          // late String name_teacher = teacher[index].name;
                                          print("profesor seleccionado:  " +
                                              teacher[index].name);
                                          _new_request(
                                              context,
                                              name,
                                              correo,
                                              argumento.materia,
                                              teacher[index].name);
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }));
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("No se pueden obtener los datos");
            }
            return Center();
          }),
    );
  }

  _new_request(context, correo, name_student, materia, name_teacher) async {
    DateTime date = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour,
        DateTime.now().minute,
        DateTime.now().second);
    final http.Response response = await http.post(
      'http://54.219.163.221:5001/students/agendar/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "pendiente": "true",
        "name": correo,
        "docente": name_teacher,
        "matricula": name_student,
        "materia": materia,
        "program": "ids",
        "cuatri": "9",
        "fecha": date.toString()
      }),
    );

    if (response.statusCode == 200) {
      print("cita agendada");
      Navigator.pushNamed(context, '/on_hold');
      print(response.body);
    } else {
      throw Exception('Failed to get question paper.');
    }
    print(name_teacher);
  }
}
