import 'dart:ui';

import 'package:flutter/material.dart';

class Init_Screen extends StatelessWidget {
  const Init_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Bienvenido a TutoApp",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(156, 255, 255, 255),
        elevation: 0.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(80.0, 250.0, 50.0, 50.0),
          child: Row(
            children: <Widget>[
              Column(
                children: [
                  IconButton(
                    icon: Image.asset('assets/student.png'),
                    iconSize: 50,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login_students');
                    },
                  ),
                  Text(
                    'Estudiante',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
              ),
              Column(
                children: [
                  IconButton(
                    icon: Image.asset('assets/woman.png'),
                    iconSize: 50,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login_teachers');
                    },
                  ),
                  Text(
                    'Profesor',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
