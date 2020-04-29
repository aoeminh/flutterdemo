import 'package:flutter/material.dart';
import 'package:flutter_app/rxdart/rxdart.dart';
import 'package:flutter_app/travel/home_page.dart';
import 'package:flutter_app/travel_ui/travel_main.dart';

import 'animation/easing_animation.dart';
import 'animation/parenting_animation_widget_home.dart';
import 'bike/bike_home.dart';
import 'chat/chat.dart';
import 'clock/clock.dart';
import 'local_event_app/home/local_app_home.dart';
import 'netflix/netflix_main.dart';

void main() => runApp(TravelPage());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('lklll'),
      ),
      body: Container(),
    );
  }
}
