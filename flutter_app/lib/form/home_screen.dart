import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({this.username,this.password});

  final username;
  final password;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home page'),
        ),
        body: Container(
          child: Center(
            child: Text( 'Hello ${widget.username} '

            ),
          ),
        ),
      ),
    );
  }
}
