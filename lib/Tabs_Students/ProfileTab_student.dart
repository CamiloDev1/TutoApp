import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab_student extends StatefulWidget {
  @override
  State<ProfileTab_student> createState() => _ProfileTab_studentState();
}

class _ProfileTab_studentState extends State<ProfileTab_student> {
  String name = "";
  String correo = "";
  String rol = "";

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    // _get_data_profile();
    super.initState();
    Timer miTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      name = await prefs.getString('name');
      correo = await prefs.getString('matricula');
      rol = await prefs.getString('rol');
      //Este codigo se ejecuta cada 20 segundos
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/student.png'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Sacramento',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
                width: 150,
                child: Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                color: Color.fromARGB(255, 219, 219, 219),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(rol),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                color: Color.fromARGB(255, 219, 219, 219),
                child: ListTile(
                  leading: Icon(Icons.mail),
                  title: Text(correo),
                ),
              )
            ],
          ),
        ));
  }
}
