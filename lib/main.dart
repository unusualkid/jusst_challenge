import 'package:flutter/material.dart';
import 'package:jusst_challenge/widgets/home_page.dart';
import 'package:web_socket_channel/io.dart';
import 'utility/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(
        title: Strings.appName,
        channel: IOWebSocketChannel.connect(API.serverHost),
      ),
    );
  }
}
