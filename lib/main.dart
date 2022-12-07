// @dart=2.9
import 'package:flutter/material.dart';
import 'package:tuto_app/Tabs_Students/list_teachers.dart';
import 'package:tuto_app/Tabs_Students/on_hold.dart';
import 'package:tuto_app/Tabs_teachers/details_of_request.dart';
import 'package:tuto_app/view/InitScreen.dart';
import 'package:tuto_app/view/LoginScreen_Students.dart';
import 'package:tuto_app/view/LoginScreen_teachers.dart';
import 'package:tuto_app/view/MainScreen_Students.dart';
import 'package:tuto_app/view/SplashScreen.dart';
import 'package:tuto_app/view/MainScreen_teachers.dart';
import 'package:tuto_app/view/sign_in.dart';
// ignore: unused_import
import 'Tabs_teachers/create_news_teacher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InitScreen());
}

class InitScreen extends StatelessWidget {
  const InitScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TutoApp',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const SplashScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/type_user': (context) => Init_Screen(),
          '/login_teachers': (context) => LoginScreen_teacher(),
          '/login_students': (context) => LoginScreen_Students(),
          '/sign_in': (context) => Sign_in_Screen(),
          '/main_teachers': (context) => MainScreen_teachers(),
          '/main_students': (context) => MainScreen_students(),
          '/create_new': (context) => create_news(),
          '/list_teachers': (context) => List_teachers(),
          '/on_hold': (context) => on_hold(),
          '/details_of_request': (context) => details_of_request(),
        });
  }
}
