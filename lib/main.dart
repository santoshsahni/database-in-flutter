import 'package:flutter/material.dart';

import 'dbhelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database Queries',
      debugShowCheckedModeBanner: false,
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final dbhelper = Databasehelper.instance;

  void insertData() async {
    Map<String, dynamic> row = {
      Databasehelper.ColumnName: "alen musk",
      Databasehelper.ColumnAge: 34,
    };
    final id = await dbhelper.insert(row);
    print(id);
  }

  void queryall() async {
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      print(row);
    });
  }

  void queryspecific() async {
    var allrows = await dbhelper.queryspecific(30);
    print(allrows);
  }

  void delete() async {
    var id = await dbhelper.delete(2);
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DataBase Queries"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: insertData,
              child: Text(
                "Insert",
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
            ),
            ElevatedButton(
              onPressed: queryall,
              child: Text(
                "Query",
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
            ),
            ElevatedButton(
              onPressed: queryspecific,
              child: Text(
                "Query specific",
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Update",
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: delete,
              child: Text(
                "Delete",
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
