import 'package:flutter/material.dart';
import 'package:jusst_challenge/widgets/home_page.dart';
import 'utility/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 15.0),
        ),
      ),
      home: HomePage(
        title: Strings.appName,
      ),
    );
  }
}
