import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuto_app/models/List_acept_teacher.dart';
import 'package:http/http.dart' as http;

class TutoringTab_teacher extends StatefulWidget {
  const TutoringTab_teacher({Key? key}) : super(key: key);

  @override
  State<TutoringTab_teacher> createState() => _TutoringTab_teacherState();
}

class _TutoringTab_teacherState extends State<TutoringTab_teacher> {
  late Future<List<List_acept_teacher>> _listOfAcepted;
  List<List_acept_teacher> acepted = [];
  List<List_acept_teacher> acepted_reverse = [];

  Future<List<List_acept_teacher>> _getCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = await prefs.getString('name');
    final response =
        await http.get("http://52.53.171.98:5000/docentes/agendas/ver/${name}");
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);
      print(jsonData);
      for (var element in jsonData) {
        if (element['pendiente'].toString() == "false") {
          String pendiente = "Aceptada";
          acepted.add(List_acept_teacher(
              element["_id"].toString(),
              element["name"],
              element["docente"],
              element["matricula"],
              element['materia'],
              element['program'],
              element['fecha'],
              pendiente));
          acepted_reverse = acepted.reversed.toList();
        }
      }
      return acepted;
    } else {
      Center(child: Text("No se pudo conectar"));
      throw Exception("Fail connection.");
    }
  }

  bool _customTileExpanded = false;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _listOfAcepted = _getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Center(
          child: Text(
            "Solicitudes en aceptadas",
            style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 1, 1, 1)),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: _listOfAcepted,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                  itemCount: acepted_reverse.length,
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
                                  ExpansionTile(
                                    title: Text(acepted_reverse[index].materia),
                                    subtitle: Text(acepted_reverse[index].name),
                                    trailing: Icon(
                                      _customTileExpanded
                                          ? Icons.arrow_drop_down_circle
                                          : Icons.arrow_drop_down,
                                    ),
                                    children: <Widget>[
                                      ListTile(
                                          title: Text(
                                              acepted_reverse[index].pendiente),
                                          subtitle: Text(
                                              acepted_reverse[index].fecha)),
                                    ],
                                    onExpansionChanged: (bool expanded) {
                                      setState(
                                          () => _customTileExpanded = expanded);
                                    },
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
              return Center(child: CircularProgressIndicator());
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
