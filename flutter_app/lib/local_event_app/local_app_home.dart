import 'package:flutter/material.dart';
import 'package:flutter_app/local_event_app/bg_part_screen_home_widget.dart';

class LocalMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xFFFF4700)),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      color: themeData.scaffoldBackgroundColor,
      child: Stack(

        children: <Widget>[
          BackgroundPartHomePage(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,),

        ],
      ),
    );
  }
}
