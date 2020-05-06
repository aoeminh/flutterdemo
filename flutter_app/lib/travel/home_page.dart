import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/travel/add_item_travel.dart';
import 'package:flutter_app/travel/add_page.dart';
import 'package:flutter_app/travel/model/my_model.dart';
import 'package:flutter_app/travel/utils.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'model/travel.dart';
import 'travel_detail.dart';

class TravelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => Travel(),
        ),
      ],
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPage(
                              travel: null,
                              isEdit: false,
                            )));
              },
              child: Container(
                  margin: EdgeInsets.only(right: 10), child: Icon(Icons.add)))
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() => Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Consumer<MyModel>(
                  builder: (context, model, child) => Container(
                        child: ListView.builder(
                            itemCount: model.travels.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => Center(
                                child: _buildItem(model.travels[index]))),
                      )),
            ),
          ],
        ),
      );

  _buildItem(Travel travel) => Card(
        color: Colors.blue,
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TravelDetail(
                        travel: travel,
                      ))),
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
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPage(
                                        travel: travel,
                                        isEdit: true,
                                      )));
                        },
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _formatDate(travel.startDate),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(getTime(travel.startDate, travel.endDate),
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    Text('${Random().nextInt(10) + 2} places',
                        style: TextStyle(color: Colors.white, fontSize: 20))
                  ],
                )
              ],
            ),
          ),
        ),
      );

  String _formatDate(int time) {
    return '${Utils.formatDate(DateTime.fromMillisecondsSinceEpoch(time), DateFormat('dd MMM'))}';
  }

  String getTime(int start, int end) {
    int time = end - start;
    if (time <= 0) {
      return '1 day';
    } else {
      DateTime startTime = DateTime.fromMillisecondsSinceEpoch(start);
      DateTime endTime = DateTime.fromMillisecondsSinceEpoch(end);
      final different = endTime.difference(startTime).inDays + 1;
      return '$different days';
    }
  }
}