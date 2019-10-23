import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TutorialDemo extends StatelessWidget {
  final String contentTextSection =
      'Once the layout has been diagrammed, it’s easiest'
      ' to take a bottom-up approach to implementing it. To minimize the visual confusion '
      'of deeply nested layout code, place some of the implementation in variables and functions.';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Tutorial Demo',
      home: Scaffold(
        body: mainColumn(),
      ),
    );
  }

  Widget mainColumn() =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          topImage(),
          titleSection(),
          buttonSelection(),
          textSection(),
        ],
      );

  Widget topImage() =>
      Image.asset(
        'assets/images/pic1.jpg',
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      );

  Widget titleSection() =>
      Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            titleColumn(),
            Expanded(
              child:FavoriteWidget(),
            ),
          ],
        ),
      );

  Widget titleColumn() =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              'Identify the rows and columns.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
          ),
          Text(
            'Does the UI need tabs',
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buttonSelection() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.call, color: Colors.blue),
              ),
              Text(
                'Call',
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.near_me, color: Colors.blue),
              ),
              Text(
                'Route',
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.share, color: Colors.blue),
              ),
              Text(
                'Share',
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ],
      );

  Widget textSection() =>
      Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Text(
          contentTextSection,
        ),
      );
}

class FavoriteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FavoriteState();
  }
}

class _FavoriteState extends State<FavoriteWidget> {
  int favoriteCount = 40;
  var color = Colors.grey;
  bool isFavorite = true;

  _onTapFavorite(){
    setState(() {
      print('setState');
      if(_toggleFavorite()){
        favoriteCount = 41;
        color = Colors.red;
      }else{
        favoriteCount = 40;
        color = Colors.grey;
      }
    });
  }

  _toggleFavorite(){
    isFavorite = !isFavorite;
    print('$isFavorite');
    return isFavorite;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Icon(
              Icons.star,
              color:color,
            ),
          ),
          Text('$favoriteCount')
        ],
      ),
      onTap:(){
        _onTapFavorite();
      },
    );
  }
}
