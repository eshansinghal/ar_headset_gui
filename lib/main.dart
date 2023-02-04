import 'package:flutter/material.dart';
import 'AppScreen.dart';
import 'Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      color: Colors.black,
      home: Home(appsUp: false,),
    );
  }
}
