import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuto_app/models/List_pending.dart';
import 'package:http/http.dart' as http;

class TutoringTab_student extends StatefulWidget {
  const TutoringTab_student({Key? key}) : super(key: key);

  @override
  State<TutoringTab_student> createState() => _TutoringTab_studentState();
}

class _TutoringTab_studentState extends State<TutoringTab_student> {
  late Future<List<List_pending>> _listOfPendings;
  List<List_pending> Pendings = [];
  List<List_pending> Pendings_reversed = [];

  Future<List<List_pending>> _getPending() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String correo = await prefs.getString('matricula');
    print(correo);
    final response = await http.get(
        "http://54.219.163.221:5001/students/agendar/pendientes/${correo}");

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);
      print(jsonData);
      for (var element in jsonData) {
        if (element["pendiente"] == "true") {
          String pendiente = "En espera";
          Pendings.add(List_pending(
              pendiente,
              element["name"],
              element["docente"],
              element["matricula"],
              element["materia"],
              element["program"],
              element["fecha"]));
          Pendings_reversed = Pendings.reversed.toList();
        }
      }

      return Pendings;
    } else {
      throw Exception("Fail connection.");
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _listOfPendings = _getPending();
  }

  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Center(
          child: Text(
            "Solicitudes en espera",
            style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 1, 1, 1)),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: _listOfPendings,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                  itemCount: Pendings_reversed.length,
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
                                    title:
                                        Text(Pendings_reversed[index].materia),
                                    subtitle:
                                        Text(Pendings_reversed[index].docente),
                                    trailing: Icon(
                                      _customTileExpanded
                                          ? Icons.arrow_drop_down_circle
                                          : Icons.arrow_drop_down,
                                    ),
                                    children: <Widget>[
                                      ListTile(
                                          title: Text(Pendings_reversed[index]
                                              .pendiente),
                                          subtitle: Text(
                                              Pendings_reversed[index].fecha)),
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
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
