import 'package:basededatos/NoteDetail.dart';
import 'package:basededatos/NoteList.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Base de Datos",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple
        
      ),
      home: NoteList(),
    );
  }
}