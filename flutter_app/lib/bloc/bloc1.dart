import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlockHome extends StatelessWidget {
  BlockHome() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //top bar color
      statusBarColor: Colors.red,
      //top bar icons
      statusBarIconBrightness: Brightness.dark,
    ));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Bloc demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class Counter {
  int count = 0;

  StreamController streamController = StreamController.broadcast();

  // sink
  Sink get sink => streamController.sink;

  // stream
  Stream get stream => streamController.stream;

  _increase() {
    ++count;
    sink.add(count);
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Counter counter = Counter();
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Text('Bloc demo'),
                  backgroundColor: Colors.blue,
                  expandedHeight: 150,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset('assets/images/pic1.jpg'),
                  ),
                )
              ],
            ),
            StreamBuilder(
              initialData: counter.count = 0,
              stream: counter.stream,
              builder: (BuildContext context, snapShot) {
                return Text('${snapShot.data}');
              },
            ),


          ],
        ),
      ),
    );
  }
}
