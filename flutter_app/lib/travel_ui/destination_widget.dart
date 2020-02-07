import 'package:flutter/material.dart';
import 'package:flutter_app/travel_ui/destination.dart';

class DestinationWidget extends StatefulWidget {
  final Destination destination;

  const DestinationWidget({Key key, this.destination}) : super(key: key);

  @override
  _DestinationWidgetState createState() => _DestinationWidgetState();
}

class _DestinationWidgetState extends State<DestinationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            child: Container(
              height: 100,
              padding: EdgeInsets.only(top: 40, left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '111 activities',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      widget.destination.description,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: widget.destination.imageUrl,
                    child: ClipRRect(
                      child: Container(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          widget.destination.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.destination.city,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            Text(
                              widget.destination.country,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
