import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/travel/add_page.dart';
import 'package:flutter_app/travel/model/my_model.dart';
import 'package:provider/provider.dart';

import 'model/travel.dart';

class TravelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyModel(),
      child: MaterialApp(
        home: TravelHome(),
      ),
    );
  }
}

class TravelHome extends StatefulWidget {
  @override
  _TravelHomeState createState() => _TravelHomeState();
}

class _TravelHomeState extends State<TravelHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        actions: <Widget>[
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPage()));
              },
              child: Icon(Icons.add))
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() => Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Hello'),
              Consumer<MyModel>(
                  builder: (context, model, child) => Container(
                        height: 500,
                        child: Center(
                          child: ListView.builder(
                              itemCount: model.travels.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => Center(
                                  child: _buildItem(model.travels[index]))),
                        ),
                      )),

            ],
          ),
        ),
      );

  _buildItem(Travel travel) => Card(
    color: Colors.blue,
    child: Container(
          height: 200,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${travel.title}',
                      style: TextStyle(fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings,color: Colors.white,),
                    onPressed: () {},
                  )
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_formatDate(travel.startDate),style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),),
                  Text(getTime(travel.startDate, travel.endDate),style: TextStyle(
                  color: Colors.white,
                      fontSize: 20
                  )),
                  Text('${Random().nextInt(10) + 2} places',style: TextStyle(
  color: Colors.white,
  fontSize: 20
  ))
                ],
              )
            ],
          ),
        ),
  );

  String _formatDate(int time) {
    int day = DateTime.fromMillisecondsSinceEpoch(time).day;
    int month = DateTime.fromMillisecondsSinceEpoch(time).month;
    return '$day ${formatMonth(month)}';
  }

  String formatMonth(int month) {
    switch (month) {
      case DateTime.january:
        return 'Jan';
      case DateTime.february:
        return 'Feb';
      case DateTime.march:
        return 'Mar';
      case DateTime.april:
        return 'Apr';
      case DateTime.may:
        return 'May';
      case DateTime.june:
        return 'Jun';
      case DateTime.july:
        return 'Jul';
      case DateTime.august:
        return 'Aug';
      case DateTime.september:
        return 'Sep';
      case DateTime.october:
        return 'Oct';
      case DateTime.november:
        return 'Nov';
      case DateTime.december:
        return 'Dec';
      default:
        return '';
    }
  }

  String getTime(int start, int end) {
    int time = end - start;
    if (time <= 0) {
      return '1 day';
    } else {
      DateTime startTime = DateTime.fromMillisecondsSinceEpoch(start);
      DateTime endTime = DateTime.fromMillisecondsSinceEpoch(end);
      final different = endTime.difference(startTime).inDays;
      print('dif $different');
      double day = ((end = start)/ 86400000) ;
      return '$day days';
    }
  }
}
