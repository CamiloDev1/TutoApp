import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuto_app/models/Data_of_request.dart';
import 'package:tuto_app/models/List_pending_teacher.dart';

class ConsultingTab_teacher extends StatefulWidget {
  @override
  State<ConsultingTab_teacher> createState() => _ConsultingTab_teacherState();
}

class _ConsultingTab_teacherState extends State<ConsultingTab_teacher> {
  late Future<List<List_pending_teacher>> _listOfPendingTeacher;
  List<List_pending_teacher> PendingTeacher = [];
  List<List_pending_teacher> PendingTeacher_reversed = [];
  Future<List<List_pending_teacher>> _getCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = await prefs.getString('name');
    final response =
        await http.get("http://52.53.171.98:5000/docentes/agendas/ver/${name}");
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);
      print(jsonData);
      for (var element in jsonData) {
        if (element['pendiente'].toString() == "true") {
          PendingTeacher.add(List_pending_teacher(
              element["_id"].toString(),
              element["name"],
              element["docente"],
              element["matricula"],
              element['materia'],
              element['program'],
              element['fecha'],
              element['pendiente']));
          PendingTeacher_reversed = PendingTeacher.reversed.toList();
          print("*************");
          print(PendingTeacher);
        }
      }
      return PendingTeacher;
    } else {
      Center(child: Text("No se pudo conectar"));
      throw Exception("Fail connection.");
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _listOfPendingTeacher = _getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Solicitudes de alumnos",
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _listOfPendingTeacher,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
                itemCount: PendingTeacher_reversed.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Card(
                            color: Color.fromARGB(255, 243, 242, 242),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.perm_identity_rounded,
                                    size: 60,
                                    color: Color.fromARGB(255, 0, 170, 248),
                                  ),
                                  title: Center(
                                      child: Text(
                                    PendingTeacher_reversed[index].name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  )),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'Ver detalles',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      onPressed: () {
                                        Text("Hola");
                                        Navigator.pushNamed(
                                            context, '/details_of_request',
                                            arguments: Data_of_request(
                                                PendingTeacher_reversed[index]
                                                    .id,
                                                PendingTeacher_reversed[index]
                                                    .name,
                                                PendingTeacher_reversed[index]
                                                    .docente,
                                                PendingTeacher_reversed[index]
                                                    .matricula,
                                                PendingTeacher_reversed[index]
                                                    .materia,
                                                PendingTeacher_reversed[index]
                                                    .program,
                                                PendingTeacher_reversed[index]
                                                    .fecha,
                                                PendingTeacher_reversed[index]
                                                    .pendiente));
                                      },
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(20),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            print(snapshot.error);
            print("Entro aqui");
            return Center(child: Text("No se pueden obtener los datos"));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
