import 'dart:io';

import 'package:flutter/services.dart';
import 'package:tuto_app/Tabs_Students/ConsultingTab_student.dart';
import 'package:tuto_app/Tabs_Students/HomeTab_student.dart';
import 'package:tuto_app/Tabs_Students/ProfileTab_student.dart';
import 'package:tuto_app/Tabs_Students/TutoringTab_student.dart';
import 'package:tuto_app/Tabs_teachers/HomeTab_teacher.dart';
import 'package:tuto_app/Tabs_teachers/ConsultingTab_teacher.dart';
import 'package:tuto_app/Tabs_teachers/ProfileTab_teacher.dart';
import 'package:tuto_app/Tabs_teachers/TutoringTab_teacher.dart';
import 'package:flutter/material.dart';

import '../models/Profile_loged.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen_students extends StatefulWidget {
  @override
  _MainScreen_studentsState createState() => _MainScreen_studentsState();
}

class _MainScreen_studentsState extends State<MainScreen_students>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  DateTime? lastPressed;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        final maxDuration = Duration(seconds: 2);
        final isWarning =
            lastPressed == null || now.difference(lastPressed!) > maxDuration;

        if (isWarning) {
          lastPressed = DateTime.now();
          final snackBar = SnackBar(
            content: Text("Doble Tap para salir"),
            duration: maxDuration,
          );
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);

          return false;
        } else {
          SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          brightness: Brightness.light,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    height: 50,
                  ),
                  Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'TutoApp Alumnos',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 27.0,
                            fontWeight: FontWeight.bold),
                      ))
                ],
                // children: <Widget>[
                //   Text('Tuto App',
                //       style: TextStyle(
                //           color: Color.fromARGB(255, 255, 255, 255),
                //           fontSize: 27.0,
                //           fontWeight: FontWeight.bold)),

                // ],
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(156, 0, 191, 255),
          elevation: 0.0,
        ),
        body: TabBarView(controller: _tabController, children: [
          HomeTab_student(),
          ConsultingTab_student(),
          TutoringTab_student(),
          ProfileTab_student(),
        ]),
        bottomNavigationBar: TabBar(
          indicatorColor: Color.fromARGB(255, 14, 166, 255),
          controller: _tabController,
          unselectedLabelColor: Color.fromARGB(255, 14, 166, 255),
          labelColor: Color.fromARGB(255, 255, 255, 255),
          tabs: [
            Tab(
                icon: Icon(
              Icons.home,
              size: 30.0,
              color: Color.fromARGB(156, 0, 191, 255),
            )),
            Tab(
                icon: Icon(
              Icons.book,
              size: 30.0,
              color: Color.fromARGB(156, 0, 191, 255),
            )),
            Tab(
                icon: Icon(
              Icons.pending_actions,
              size: 30.0,
              color: Color.fromARGB(156, 0, 191, 255),
            )),
            Tab(
                icon: Icon(
              Icons.person,
              size: 30.0,
              color: Color.fromARGB(156, 0, 191, 255),
            ))
          ],
        ),
      ),
    );
  }
}
