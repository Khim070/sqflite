import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test5/view/main_screen.dart';

import 'Page.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.amberAccent,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(title: 'Flutter SQFlite'));
  }
}
