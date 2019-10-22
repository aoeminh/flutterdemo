
import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stack demo'),

        ),
        body: _buildStack() ,
      ),
    );
  }

  _buildStack()    => Stack(
    alignment: const Alignment(0.6, 0.6),
    children: [
      CircleAvatar(
        backgroundImage: AssetImage('assets/images/pic0.jpg'),
        radius: 100,
      ),
      Container(

        child: Text(
          'Mia B'  ,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),

        ),
      )
    ],
  );



}

