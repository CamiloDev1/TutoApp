import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuto_app/CustomIcons.dart';
import 'package:tuto_app/Widgets/FormCard_student.dart';
import 'package:tuto_app/Widgets/SocialIcons.dart';
import 'package:tuto_app/CustomIcons.dart';
import 'package:http/http.dart' as http;
import 'package:tuto_app/models/Profile_loged.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen_Students extends StatefulWidget {
  @override
  _LoginScreen_StudentsState createState() => new _LoginScreen_StudentsState();
}

class _LoginScreen_StudentsState extends State<LoginScreen_Students> {
  String _name = "";
  String _correo = "";
  bool _isSelected = false;
  var message = "";
  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  login_student(nameStr, passStr) async {
    late Future<List<Profile_loged>> _listOfdata;
    List<Profile_loged> data = [];
    print("Entro aqui");
    final http.Response response = await http.post(
      'http://54.219.163.221:5001/alumnos/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'correo': nameStr,
        'password': passStr,
      }),
    );
    print("lllego aqui");
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);
      // print(jsonData);
      print("Shared Preferences");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', jsonData['name']);
      await prefs.setString('matricula', jsonData['correo']);
      await prefs.setString('rol', jsonData['rol']);
      print("Guardado");
      print("entro if");
      Navigator.pushNamed(context, '/main_students');
      print(response.body);
    } else {
      print(response.body);
      print("Entro else");
      message = "Correo o contraseña incorrectos";
      // throw Exception('Failed to get question paper.');
    }
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  TextEditingController myController_mail = TextEditingController();
  TextEditingController myController_pass = TextEditingController();

  @override
  void dispose() {
    myController_mail.dispose();
    myController_pass.dispose();
    super.dispose();
  }

  late bool _passwordVisible;
  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Image.asset("assets/image_01.png"),
              ),
              Expanded(
                child: Container(),
              ),
              Image.asset("assets/image_02.png")
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/logo.png",
                        width: ScreenUtil.getInstance().setWidth(110),
                        height: ScreenUtil.getInstance().setHeight(110),
                      ),
                      Text("TutoApp",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(46),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  _login_data(),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(640),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                var nameStr = myController_mail.text.toString();
                                var passStr = myController_pass.text.toString();
                                if (nameStr != null && passStr != null) {
                                  login_student(nameStr, passStr);
                                } else {
                                  message = "Uno de los campos esta vacio";
                                }
                              },
                              child: Center(
                                child: Text("Iniciar Sesión",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  horizontalLine(),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _login_data() {
    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(500),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Iniciar sesion - Alumno",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(35),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .8)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            TextField(
              controller: myController_mail,
              decoration: InputDecoration(
                  hintText: "Correo institucional",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 61, 55, 55), fontSize: 14.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: myController_pass,
              obscureText:
                  !_passwordVisible, //This will obscure text dynamically
              decoration: InputDecoration(
                labelText: 'Contraseña',
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 61, 55, 55), fontSize: 14.0),
                // Here is key idea
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            // TextField(
            //   controller: myController_pass,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //       hintText: "Contraseña",
            //       hintStyle: TextStyle(
            //           color: Color.fromARGB(255, 61, 55, 55), fontSize: 14.0)),
            // ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(15),
            ),
            Text(message,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: ScreenUtil.getInstance().setSp(22),
                    letterSpacing: .8)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign_in');
                  },
                  child: const Text('Registrarse'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
