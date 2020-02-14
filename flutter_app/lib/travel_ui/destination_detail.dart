import 'package:flutter/material.dart';
import 'package:flutter_app/travel_ui/activity_widget.dart';
import 'package:flutter_app/travel_ui/destination.dart';

class DestinationDetail extends StatefulWidget {
  final Destination destination;

  const DestinationDetail({Key key, this.destination}) : super(key: key);

  @override
  _DestinationDetailState createState() => _DestinationDetailState();
}

class _DestinationDetailState extends State<DestinationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                  child: Hero(
                    tag: widget.destination.imageUrl,
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20)),
                        child: Image.asset(
                          widget.destination.imageUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                _toolbar(),
                _info(),

              ],
            ),
            SizedBox(height: 20,),
            _listActivity()
          ],
        ),
      ),
    );
  }

  _toolbar() => Positioned(
        top: 30,
        left: 10,
        right: 10,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.arrow_back),
              Row(
                children: <Widget>[
                  Icon(Icons.search),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.menu)
                ],
              )
            ],
          ),
        ),
      );

  _info() => Positioned(
        bottom: 20,
        left: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.destination.city,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.location_on, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.destination.country,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            )
          ],
        ),
      );

  _listActivity() => Container(

    child: ListView.builder(

        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: activities.length,
        itemBuilder: (BuildContext context, int index){
          return ActivityWidget(activity: activities[index],

          );

    }),
  );

}
