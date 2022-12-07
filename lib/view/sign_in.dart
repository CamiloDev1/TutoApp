import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:tuto_app/CustomIcons.dart';
import 'package:tuto_app/Widgets/FormCard_register.dart';
import 'package:tuto_app/Widgets/FormCard_student.dart';
import 'package:tuto_app/Widgets/SocialIcons.dart';
import 'package:tuto_app/CustomIcons.dart';

class Sign_in_Screen extends StatefulWidget {
  @override
  _Sign_in_ScreenState createState() => new _Sign_in_ScreenState();
}

class _Sign_in_ScreenState extends State<Sign_in_Screen> {
  var message = "";

  RegExp exp_ids = RegExp(
    r"^[0-9]+[@]+[i]+[d]+[s]+[.]+[u]+[p]+[c]+[h]+[i]+[a]+[p]+[a]+[s]+[.]+[e]+[d]+[u]+[.]+[m]+[x]",
  );
  RegExp exp_ids_teacher = RegExp(
    r"^[a-zA-Z]+[@]+[i]+[d]+[s]+[.]+[u]+[p]+[c]+[h]+[i]+[a]+[p]+[a]+[s]+[.]+[e]+[d]+[u]+[.]+[m]+[x]",
  );
  bool _isSelected = false;
  String? gender;
  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
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
  TextEditingController myController_name = TextEditingController();
  // TextEditingController myController_name = TextEditingController();
  @override
  void dispose() {
    myController_mail.dispose();
    myController_pass.dispose();
    myController_name.dispose();
    super.dispose();
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
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 100.0),
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
                    height: ScreenUtil.getInstance().setHeight(90),
                  ),
                  // FormCard_register(),
                  _card_register(),
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
                              onTap: () async {
                                var nameStr = myController_name.text.toString();
                                var passStr = myController_pass.text.toString();
                                var correoStr =
                                    myController_mail.text.toString();
                                if (gender == "Alumno") {
                                  if (exp_ids.hasMatch(correoStr) == true) {
                                    if (nameStr != null &&
                                        passStr != null &&
                                        correoStr != null &&
                                        gender != null) {
                                      final http.Response response =
                                          await http.post(
                                        'http://54.219.163.221:5001/students',
                                        headers: <String, String>{
                                          'Content-Type':
                                              'application/json; charset=UTF-8',
                                        },
                                        body: jsonEncode(<String, String>{
                                          'name': nameStr,
                                          'password': passStr,
                                          'rol': gender.toString(),
                                          'correo': correoStr
                                        }),
                                      );

                                      if (response.statusCode == 200) {
                                        Navigator.pushNamed(
                                            context, '/type_user');
                                        print(response.body);
                                      } else {
                                        throw Exception(
                                            'Failed to get question paper.');
                                      }
                                    }
                                  } else {
                                    message = "Correo institucional no valido";
                                    print("Correo de alumno no valido");
                                  }
                                }
                                if (gender == "Profesor") {
                                  if (exp_ids_teacher.hasMatch(correoStr) ==
                                      true) {
                                    final http.Response response =
                                        await http.post(
                                      'http://52.53.171.98:5000/docentes',
                                      headers: <String, String>{
                                        'Content-Type':
                                            'application/json; charset=UTF-8',
                                      },
                                      body: jsonEncode(<String, String>{
                                        'name': nameStr,
                                        'password': passStr,
                                        'rol': gender.toString(),
                                        'correo': correoStr
                                      }),
                                    );

                                    if (response.statusCode == 200) {
                                      Navigator.pushNamed(
                                          context, '/type_user');
                                      print(response.body);
                                    } else {
                                      throw Exception(
                                          'Failed to get question paper.');
                                    }
                                  } else {
                                    message = "Correo institucional no valido";
                                  }
                                }
                              },
                              child: Center(
                                child: Text("Registrarse",
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

  _card_register() {
    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(800),
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
            Text("Registrarse",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(35),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .8)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
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
              height: ScreenUtil.getInstance().setHeight(15),
            ),
            Text(message,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: ScreenUtil.getInstance().setSp(22),
                    letterSpacing: .8)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            TextField(
              controller: myController_pass,
              // obscureText: true,
              decoration: InputDecoration(
                  hintText: "Contraseña",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 61, 55, 55), fontSize: 14.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            TextField(
              controller: myController_name,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: "Nombre completo",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 61, 55, 55), fontSize: 14.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            RadioListTile(
              title: Text("Alumno"),
              value: "Alumno",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                  print(gender);
                });
              },
            ),
            RadioListTile(
              title: Text("Profesor"),
              value: "Profesor",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                  print(gender);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
