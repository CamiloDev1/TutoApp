import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tuto_app/models/News_teachers.dart';
import 'package:http/http.dart' as http;

class HomeTab_teacher extends StatefulWidget {
  const HomeTab_teacher({Key? key}) : super(key: key);

  @override
  State<HomeTab_teacher> createState() => _HomeTab_teacherState();
}

class _HomeTab_teacherState extends State<HomeTab_teacher> {
  late Future<List<News_teachers>> _listOfNewsForTeachers;
  List<News_teachers> news = [];

  Future<List<News_teachers>> _getNews() async {
    final response = await http.get("http://13.56.20.66:5002/notices");

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);
      print(jsonData);
      for (var element in jsonData) {
        news.add(News_teachers(
            element["id"],
            element["title"],
            element["description"],
            element["image"],
            element["date"],
            element["type"].toString()));
      }

      return news;
    } else {
      throw Exception("Fail connection.");
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _listOfNewsForTeachers = _getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: _listOfNewsForTeachers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 20.0,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                news[index].title,
                                style: TextStyle(fontSize: 25),
                              ),
                              subtitle: Text(
                                news[index].date,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              height: 200.0,
                              child: Image(
                                image: NetworkImage(news[index].image_link),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                news[index].description,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ],
                        ));
                  });
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("No se pueden obtener los datos");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add_circle_outline,
              size: 45,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/create_new');
            }));
  }
}
