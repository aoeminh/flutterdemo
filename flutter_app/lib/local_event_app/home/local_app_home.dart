import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/local_event_app/home/bg_part_screen_home_widget.dart';
import 'package:flutter_app/local_event_app/home/category_widget.dart';
import 'package:flutter_app/local_event_app/home/event_widget.dart';
import 'package:flutter_app/local_event_app/model/category.dart';
import 'package:flutter_app/local_event_app/model/data.dart';
import 'package:flutter_app/local_event_app/model/event.dart';

const double _paddingLarge = 20.0;
const double _paddingSmall = 15.0;

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
  var currentCategoryType = CategoryType.ALL;
  List<Event> currentEvents = events;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: themeData.scaffoldBackgroundColor,
          child: Stack(
            children: <Widget>[
              BackgroundPartHomePage(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              _body(),
              _marginLarge(),
            ],
          ),
        ),
      ),
    );
  }

  _body() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          _header(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: _paddingLarge),
            child: Text(
              'What\'s Up',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
          ),
          _marginLarge(),
          _listCategory()
        ],
      );

  _header() => Container(
        margin: EdgeInsets.symmetric(horizontal: _paddingLarge),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'LOCAL EVENTS',
              style: TextStyle(
                  color: Color(0x99FFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Icon(
              Icons.person,
              color: Color(0x99FFFFFF),
            )
          ],
        ),
      );

  _listCategory() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: Data.categoryList.map((category) {
            return InkWell(
              onTap: () {
                setState(() {
                  currentEvents =  events.where((event) => event.categoryType.contains(currentCategoryType)).toList();
                  currentCategoryType = category.categoryType;
                });
              },
              child: CategoryWidget(
                isSelected:
                currentCategoryType == category.categoryType,
                icon: category.icon,
                title: category.title,
              ),
            );
          }).toList(),
        ),
      );

  _marginLarge() => SizedBox(
        height: 20,
      );

  _listEvent() => ListView.builder(itemBuilder: (context, index){

//    var newEventList = List();
//    for(int i = 0; i< events.length; i++){
//      if(events[i].categoryType.contains(currentCategoryType)){
//        newEventList.add(events[i]);
//      }
//    }
    List<Event> newEvent = events.where((event) => event.categoryType.contains(currentCategoryType)).toList();
     return InkWell(
       onTap: (){},
       child: EventWidget(
         imagePath: ,

       ),
     );


  });
}
