import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tuto_app/models/News_teachers.dart';
import 'package:http/http.dart' as http;

class HomeTab_student extends StatefulWidget {
  const HomeTab_student({Key? key}) : super(key: key);

  @override
  State<HomeTab_student> createState() => _HomeTab_studentState();
}

class _HomeTab_studentState extends State<HomeTab_student> {
  late Future<List<News_teachers>> _listOfNewsForTeachers;
  List<News_teachers> news = [];
  List<News_teachers> news_reversed = [];
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
        news_reversed = news.reversed.toList();
        print(news);
        print("***********");
        print(news_reversed);
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
                itemCount: news_reversed.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 20.0,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              news_reversed[index].title,
                              style: TextStyle(fontSize: 25),
                            ),
                            subtitle: Text(
                              news_reversed[index].date,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Container(
                            height: 200.0,
                            child: Image(
                              image:
                                  NetworkImage(news_reversed[index].image_link),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              news_reversed[index].description,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ],
                      ));
                });
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
