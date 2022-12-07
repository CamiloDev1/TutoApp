import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab_teacher extends StatefulWidget {
  const ProfileTab_teacher({Key? key}) : super(key: key);

  @override
  State<ProfileTab_teacher> createState() => _ProfileTab_teacherState();
}

class _ProfileTab_teacherState extends State<ProfileTab_teacher> {
  String name = "";
  String correo = "";
  String rol = "";
  Future<void> _get_data_profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = await prefs.getString('name');
    correo = await prefs.getString('matricula');
    rol = await prefs.getString('rol');
  }

  @override
  void _dispose() {
    _get_data_profile();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _get_data_profile();
    super.initState();
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
                radius: 70,
                backgroundImage: AssetImage('assets/teacher.png'),
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
