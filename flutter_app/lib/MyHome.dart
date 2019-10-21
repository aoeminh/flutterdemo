import 'dart:math';

import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  MyHome({Key key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String textToShow = "This is demo app";

  bool toogle = true;

  _toogle() {
    setState(() {
      toogle = !toogle;
    });
  }

  _getToggleChild() {
    if (toogle) {
      return Text('I\'m toggle');
    } else {
      return MaterialButton(onPressed: (){},
      child: Text('Material button'));
    }
  }

  _updateText() {
    setState(() {
      textToShow = "Hello 1";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Flutter'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: _getToggleChild()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toogle,
        child: Icon(Icons.add),
        tooltip: 'Update text',
      ),
    );
  }
}
