import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TutorialDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Tutorial Demo',
      home: Scaffold(
        body:mainColumn(),
      ),
    );
  }

  Widget mainColumn() =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          topImage(),
          titleSection()
        ],
      );

  Widget topImage() =>
      Image.asset('assets/images/pic1.jpg', fit: BoxFit.cover,);

  Widget titleSection() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      titleColumn(),
      Icon(Icons.star,color: Colors.red,),
      Text('41')
    ],
  );

  Widget titleColumn() =>  Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text('Identify the rows and columns.',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),),
      Text('Does the UI need tabs',
      style: TextStyle(
        color: Colors.grey
      ),)
    ],

  );
}