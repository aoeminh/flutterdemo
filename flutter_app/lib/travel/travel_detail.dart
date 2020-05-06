import 'package:flutter/material.dart';
import 'package:flutter_app/travel/add_item_travel.dart';
import 'package:flutter_app/travel/model/travel.dart';
import 'package:provider/provider.dart';

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
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          AddItemTravel(widget.travel))),
                  child: Icon(Icons.add)))
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() =>
      Column(
        children: <Widget>[
          Container(
            child: Consumer<Travel>(
              builder: (context, model, child) =>
                  Expanded(
                    child: Container(
                      height: 500,
                      child: ListView.builder(
                          itemCount: model.itemTravels.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                        return Container(
                          child: Text(
                              '${model.itemTravels[index].title}'
                          ),
                        );
                      }),
                    ),
                  ),
            ),
          ),
        ],
      );
}
