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
  Future<Map<String, dynamic>> _get_data_profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "name": await prefs.getString('name'),
      "matricula": await prefs.getString('matricula'),
      "rol": await prefs.getString('rol')
    };
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
        body: FutureBuilder<Map<String, dynamic>>(
          future: _get_data_profile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
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
                      snapshot.data!["name"],
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      color: Color.fromARGB(255, 219, 219, 219),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(snapshot.data!["rol"]),
                      ),
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      color: Color.fromARGB(255, 219, 219, 219),
                      child: ListTile(
                        leading: Icon(Icons.mail),
                        title: Text(snapshot.data!["matricula"]),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
