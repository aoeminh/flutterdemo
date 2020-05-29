import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/travel/firebase/firebasedb.dart';
import 'package:flutter_app/travel/model/item_travel.dart';
import 'package:flutter_app/travel/model/travel.dart';
import 'package:flutter_app/travel/utils.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'add_place.dart';

class TravelDetail extends StatefulWidget {
  final Travel travel;
  final String uid;

  TravelDetail({this.travel, this.uid});

  @override
  _TravelDetailState createState() => _TravelDetailState();
}

class _TravelDetailState extends State<TravelDetail> {
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    FirebaseDB.instance
        .getListPlaces(widget.uid, widget.travel.id)
        .then((DataSnapshot value) {
      Map<dynamic, dynamic> map = value.value;
      widget.travel.clearListPlaces();

      if (map != null) {
        map.forEach((key, value) {
          Place place = Place.fromJson(value);
          print('${place.image}');
          widget.travel.addPlace(
              DateTime.fromMillisecondsSinceEpoch(place.startTime), place);
        });
      }
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.travel,
      child: Consumer<Travel>(
        builder: (context, travel, child) => Scaffold(
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
                              builder: (context) => AddPlace(travel: widget.travel,))),
                      child: Icon(Icons.add)))
            ],
          ),
          body: _buildBody(travel),
        ),
      ),
    );
  }

  _buildBody(Travel model) {
    List<DateTime> iterable;
    if (model.item != null) {
      iterable = model.item.keys.toList();
      iterable.sort((item1, item2) => item1.compareTo(item2));
    }
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
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
              )
            ],
          ),
          Offstage(
            offstage: !_isLoading,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }

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
                  color: Colors.blue,
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

  _buildItem(Place place) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 2,
              height: 30,
              color: Colors.blue,
              margin: EdgeInsets.only(left: 59),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue),
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              Utils.formatDate(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      place.time),
                                  DateFormat('hh:mm')),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(place.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,)),
                      ),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => AddPlace(travel: widget.travel,place:place ,),)),
                              child: Icon(Icons.settings,color: Colors.white,)))
                    ],
                  ),
                  SizedBox(height: 20,),

                  place.location != null
                      ? Text('${place.location}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold))
                      : Container(),
                  place.image == null || place.image == ''
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: place.image,
                            height: 300,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => CircularProgressIndicator(
//                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      );
}
