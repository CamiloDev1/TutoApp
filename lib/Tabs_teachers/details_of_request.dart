import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuto_app/models/Data_of_request.dart';
import 'package:tuto_app/models/List_pending_teacher.dart';
import 'package:http/http.dart' as http;

class details_of_request extends StatefulWidget {
  @override
  State<details_of_request> createState() => _details_of_requestState();
}

class _details_of_requestState extends State<details_of_request> {
  @override
  Widget build(BuildContext context) {
    Data_of_request? argumento =
        ModalRoute.of(context)!.settings.arguments as Data_of_request?;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Detalles",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 50.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.person_outline,
                  color: Color.fromARGB(255, 25, 128, 247),
                  size: 100,
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(50),
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Nombre del alumo:   ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    argumento!.name,
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(50),
              ),
              Row(
                children: [
                  Text(
                    "Carrera:   ",
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    argumento.program,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(50),
              ),
              Row(
                children: [
                  Text(
                    "Materia:   ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    argumento.materia,
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(50),
              ),
              Row(
                children: [
                  Text(
                    "Hora y fecha:   ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    argumento.fecha,
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(180),
              ),
              TextButton.icon(
                  onPressed: () {
                    print(argumento.id);
                    final splitted = argumento.id.split(' ');
                    final pos = splitted[1].length - 1;
                    final result = splitted[1].substring(0, pos);
                    print(result);
                    DateTime date = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        DateTime.now().hour,
                        DateTime.now().minute,
                        DateTime.now().second);
                    // print(splitted[1]);
                    print(date);
                    _acept_Consulting(result, date);
                  },
                  icon: Icon(
                    Icons.check_circle,
                    size: 35,
                  ),
                  label: Text(
                    "Aceptar",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _acept_Consulting(id, fecha) async {
    final http.Response response = await http.put(
      'http://52.53.171.98:5000/docentes/agendas/ver/aceptar/${id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'pendiente': 'false',
        'fecha': fecha.toString()
        // 'title': title,
        // 'description': description,
        // 'image': image_link,
        // 'date': date,
        // 'type': type
      }),
    );
    if (response.statusCode == 200) {
      print("se actualizo");
      print(response.body);
      Navigator.pop(context);
    } else {
      throw Exception('Failed to get question paper.');
    }
  }
}
