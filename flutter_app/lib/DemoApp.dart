import 'package:flutter/material.dart';
import 'package:flutter_app/MyHome.dart';

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Demo App',
      theme: ThemeData(primaryColor: Colors.green),
      home: MyHome(),
    );
  }
}
