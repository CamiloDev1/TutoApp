import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class on_hold extends StatefulWidget {
  @override
  State<on_hold> createState() => _on_holdState();
}

class _on_holdState extends State<on_hold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Solicitud enviada",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(250),
              ),
              Center(
                child: Icon(
                  Icons.access_time,
                  color: Color.fromARGB(255, 25, 128, 247),
                  size: 200,
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(100),
              ),
              Center(
                child: Text(
                  "Esperando respuesta del profesor",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 13, 56, 105),
                  ),
                ),
              ),
              Center(
                child: Icon(
                  Icons.back_hand_outlined,
                  color: Color.fromARGB(255, 25, 128, 247),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
