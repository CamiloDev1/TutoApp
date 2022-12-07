import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FormCard_register extends StatefulWidget {
  @override
  State<FormCard_register> createState() => _FormCard_registerState();
}

class _FormCard_registerState extends State<FormCard_register> {
  //Expresion regular para validar correo institucional Ingenieria en desarrollo de software
  RegExp exp_ids = RegExp(
    r"^[0-9a-zA-Z]+[@]+[i]+[d]+[s]+[.]+[u]+[p]+[c]+[h]+[i]+[a]+[p]+[a]+[s]+[.]+[e]+[d]+[u]+[.]+[m]+[x]",
  );
  //Expresion regular para validar correo institucional Ingenieria Agroindustrial
  RegExp exp_ia = RegExp(
      r"^[0-9a-zA-Z]+[@]+[i]+[a]+[.]+[u]+[p]+[c]+[h]+[i]+[a]+[p]+[a]+[s]+[.]+[e]+[d]+[u]+[.]+[m]+[x]");
  //Expresion regular para validar correo institucional Ingenieria Biomedica
  RegExp exp_bio = RegExp(
      r"^[0-9a-zA-Z]+[@]+[i]+[b]+[.]+[u]+[p]+[c]+[h]+[i]+[a]+[p]+[a]+[s]+[.]+[e]+[d]+[u]+[.]+[m]+[x]");
  //Expresion regular para validar correo institucional Ingenieria Mecatronica
  RegExp exp_im = RegExp(
      r"^[0-9a-zA-Z]+[@]+[i]+[m]+[.]+[u]+[p]+[c]+[h]+[i]+[a]+[p]+[a]+[s]+[.]+[e]+[d]+[u]+[.]+[m]+[x]");
  //Expresion regular para validar correo institucional Ingenieria tecnologia en manofactura
  RegExp exp_itm = RegExp(
      r"^[0-9a-zA-Z]+[@]+[i]+[t]+[m]+[.]+[u]+[p]+[c]+[h]+[i]+[a]+[p]+[a]+[s]+[.]+[e]+[d]+[u]+[.]+[m]+[x]");
  //Expresion regular para validar correo institucional Ingenieria en Energias
  RegExp exp_ie = RegExp(
      r"^[0-9a-zA-Z]+[@]+[i]+[e]+[.]+[u]+[p]+[c]+[h]+[i]+[a]+[p]+[a]+[s]+[.]+[e]+[d]+[u]+[.]+[m]+[x]");

  String? selectedValue;

  final TextEditingController textEditingController = TextEditingController();
  String? gender;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(850),
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
              decoration: InputDecoration(
                  hintText: "Correo institucional",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 61, 55, 55), fontSize: 14.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Contraseña",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 61, 55, 55), fontSize: 14.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            TextField(
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
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
