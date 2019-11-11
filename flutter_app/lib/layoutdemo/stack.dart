
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

  _buildStack()    => Container(
    width: double.infinity,
    height: 200,
    child: Stack(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/pic0.jpg'),
          radius: 100,
        ),
       Positioned(
          bottom: 5,
         right: 5,
         child: Padding(
           padding: const EdgeInsets.all(20.0),
           child: Text('AAAA'),
         ),
       ),
        Positioned(
          top: 5,
          left: 5,
          child: Text('AAAA'),
        )
      ],
    ),
  );



}

