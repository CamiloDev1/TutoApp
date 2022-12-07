import 'dart:convert';
import 'dart:ffi';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:tuto_app/models/course.dart';
import 'package:http/http.dart' as http;

import '../models/Data.dart';

class ConsultingTab_student extends StatefulWidget {
  @override
  State<ConsultingTab_student> createState() => _ConsultingTab_studentState();
}

class _ConsultingTab_studentState extends State<ConsultingTab_student> {
  late Future<List<course>> _listOfCourses;
  List<course> courses = [];

  Future<List<course>> _getCourses(num) async {
    final response =
        await http.get("http://52.53.171.98:5000/docentes/materias/ids/${num}");
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);
      print(jsonData);
      for (var element in jsonData) {
        courses.add(
            course(element["name"], element["cuatri"], element["program"]));
      }

      return courses;
    } else {
      throw Exception("Fail connection.");
    }
  }

  var num;
  final List<String> items = [
    'cuatrimestre 1',
    'cuatrimestre 2',
    'cuatrimestre 3',
    'cuatrimestre 4',
    'cuatrimestre 5',
    'cuatrimestre 6',
    'cuatrimestre 7',
    'cuatrimestre 8',
    'cuatrimestre 9',
  ];
  String? selectedValue;

  final TextEditingController textEditingController = TextEditingController();

  String? gender;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _listOfCourses = _getCourses(num);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    'Cuatrimestre',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                      select_courses(selectedValue);
                      print(selectedValue);
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: 200,
                  itemHeight: 40,
                  dropdownMaxHeight: 200,
                  searchController: textEditingController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Buscar',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value.toString().contains(searchValue));
                  },
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      textEditingController.clear();
                    }
                  },
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              _card_courses_list(),
              // _card_courses(context),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> select_courses(String? selectedValue) async {
    switch (selectedValue) {
      case "cuatrimestre 1":
        num = "1";
        courses.clear();
        break;
      case "cuatrimestre 2":
        num = "2";
        courses.clear();
        break;
      case "cuatrimestre 3":
        num = "3";
        courses.clear();
        break;
      case "cuatrimestre 4":
        num = "4";
        courses.clear();
        break;
      case "cuatrimestre 5":
        num = "5";
        courses.clear();
        break;
      case "cuatrimestre 6":
        num = "6";
        courses.clear();
        break;
      case "cuatrimestre 7":
        num = "7";
        courses.clear();
        break;
      case "cuatrimestre 8":
        num = "8";
        courses.clear();
        break;
      case "cuatrimestre 9":
        num = "9";
        courses.clear();
        break;
      default:
        {
          //statements;
        }
        break;
    }
  }

  _card_courses_list() {
    // courses.clear();
    return Container(
        width: double.infinity,
        height: 500,
        child: FutureBuilder(
          // future: _listOfCourses,
          future: _getCourses(num),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.collections_bookmark_outlined,
                            size: 30,
                          ),
                          title: Center(
                              child: Text(
                            courses[index].name,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: Text(
                                'Ver',
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                // final data = Data(materia: courses[index].name);
                                // Data agreg =
                                //     new Data(materia: courses[index].name);
                                // print(
                                //     "De la instancia Data:  " + agreg.materia);
                                print(courses[index].name);
                                Navigator.pushNamed(context, '/list_teachers',
                                    arguments: Data(courses[index].name));
                              },
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ));
                  });
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text("No se pueden obtener los datos"));
            }
            return Center();
          },
        ));
  }

  // _card_courses(context) {
  //   for (var element in courses) {
  //     if (element.cuatri == num.toString()) {
  //       print(element.name);
  //     }
  //   }
  // }
}
