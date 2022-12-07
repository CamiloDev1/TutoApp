import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCard_student extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
