import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Container',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Container'),
        ),
        body: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 10),
              borderRadius: BorderRadius.all(const Radius.circular(10))),
          margin: EdgeInsets.all(10),
          child: buildColumn(),
        ),
      ),
    );
  }

  Widget buildColumn() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildFirstRow(),
          buildSecondRow(),
        ],
      );

  Widget buildFirstRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 10,color: Colors.amberAccent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Image.asset(
                'assets/images/pic1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 10,color: Colors.amberAccent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Image.asset(
                'assets/images/pic2.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );

  Widget buildSecondRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 10,color: Colors.amberAccent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Image.asset(
                'assets/images/pic2.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 10,color: Colors.amberAccent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Image.asset(
                'assets/images/pic1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
}
