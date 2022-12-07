import 'package:tuto_app/Tabs_teachers/HomeTab_teacher.dart';
import 'package:tuto_app/Tabs_teachers/ConsultingTab_teacher.dart';
import 'package:tuto_app/Tabs_teachers/ProfileTab_teacher.dart';
import 'package:tuto_app/Tabs_teachers/TutoringTab_teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen_teachers extends StatefulWidget {
  @override
  _MainScreen_teachersState createState() => _MainScreen_teachersState();
}

class _MainScreen_teachersState extends State<MainScreen_teachers>
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
                        'TutoApp Profesores',
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
          HomeTab_teacher(),
          ConsultingTab_teacher(),
          TutoringTab_teacher(),
          ProfileTab_teacher(),
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
              Icons.pending_actions,
              size: 30.0,
              color: Color.fromARGB(156, 0, 191, 255),
            )),
            Tab(
                icon: Icon(
              Icons.check_circle_rounded,
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
