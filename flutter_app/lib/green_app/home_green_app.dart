import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeGreen extends StatelessWidget {
  HomeGreen() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(

        //top bar color
        statusBarColor: Colors.transparent,
        //top bar icons
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                _buildHeader(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildHeader() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.arrow_back_ios),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 250,
            child: Text(
              'Fiddle Lead Fig Topiary',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '10 Nusery',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: '\$ ',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              TextSpan(
                  text: '85',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green))
            ]),
          ),
        ],
      );

}
