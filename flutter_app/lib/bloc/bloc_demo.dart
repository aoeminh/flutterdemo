import 'dart:async';
import 'dart:math';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorBloc {
  // stream of Color
  StreamController streamListController = StreamController<Color>.broadcast();

  // sink
  Sink get sink => streamListController.sink;

  // stream
  Stream get stream => streamListController.stream;

  _changeColor(){
    sink.add(getColor());
  }
  // get random color
  Color getColor() {
    Random _random = Random();
    return Color.fromARGB(
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }
}

class BlocDemo extends StatelessWidget {
  final ColorBloc colorBloc = ColorBloc();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Bloc demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bloc demo'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              StreamBuilder(
                initialData: Colors.red,
                stream: colorBloc.stream,
                builder: (context, AsyncSnapshot snapShot) => Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    color: snapShot.data,
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Change color'),
                color: Colors.green,
                onPressed: () {
                  colorBloc._changeColor();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

