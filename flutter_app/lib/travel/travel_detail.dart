import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/travel/add_item_travel.dart';
import 'package:flutter_app/travel/model/item_travel.dart';
import 'package:flutter_app/travel/model/travel.dart';
import 'package:flutter_app/travel/utils.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TravelDetail extends StatefulWidget {
  final Travel travel;

  TravelDetail({this.travel});

  @override
  _TravelDetailState createState() => _TravelDetailState();
}

class _TravelDetailState extends State<TravelDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
        title: Text('${widget.travel.title}'),
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 10),
              child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddItemTravel(widget.travel))),
                  child: Icon(Icons.add)))
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() => Container(
        child: Column(
          children: <Widget>[
            Consumer<Travel>(builder: (context, model, child) {
              List<DateTime> iterable;
              if (model.item != null) {
                iterable = model.item.keys.toList();
                iterable.sort((item1, item2) => item1.compareTo(item2));
                iterable.forEach(print);
              }
              return Expanded(
                child: model.item != null
                    ? ListView.builder(
                        itemCount: model.item.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          model.item[iterable[index]].sort((item1, item2) =>
                              item1.time.compareTo(item2.time));
                          return Column(
                            children: <Widget>[
                              _buildHeader(Utils.formatDate(
                                  iterable[index], DateFormat('dd MMM'))),
                              Column(
                                children: <Widget>[
                                  ...model.item[iterable[index]]
                                      .map((e) => _buildItem(e))
                                ],
                              )
                            ],
                          );
                        })
                    : Container(),
              );
            }),
          ],
        ),
      );

  _buildHeader(String time) => Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(left: 50, right: 10, top: 10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.red),
                ),
                Container(
                  width: 2,
                  height: 20,
                  color: Colors.black12,
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Text('$time',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)))
          ],
        ),
      );

  _buildItem(ItemTravel travel) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 2,
              height: 30,
              color: Colors.black12,
              margin: EdgeInsets.only(left: 59),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue),
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            Utils.formatDate(
                                DateTime.fromMillisecondsSinceEpoch(
                                    travel.time),
                                DateFormat('hh:mm')),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                      Text(travel.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  travel.image == null
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child: Image.file(
                            travel.image,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      );
}
