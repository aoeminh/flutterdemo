import 'package:flutter/material.dart';

class CookieHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Cookie(),
    );
  }
}

class Cookie extends StatefulWidget {
  @override
  _CookieState createState() => _CookieState();
}

class _CookieState extends State<Cookie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cookie House'),
      ),
    );
  }
}

