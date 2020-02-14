import 'package:flutter/material.dart';
import 'package:flutter_app/travel_ui/Activity.dart';

class ActivityWidget extends StatefulWidget {
  final Activity activity;

  const ActivityWidget({Key key, this.activity}) : super(key: key);

  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    widget.activity.imageUrl,
                    fit: BoxFit.fitHeight,
                  )),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.activity.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.activity.type,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: List.generate(widget.activity.rating, (indext) {
                      return Icon(
                        Icons.star,
                        color: Colors.yellow,
                      );
                    }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: widget.activity.startTimes
                        .map((item) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.circular(15)),
                              height: 40,
                              width: 70,
                              margin: EdgeInsets.only(right: 20),
                              child: Center(
                                child: FittedBox(
                                  child: Text(item),
                                ),
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              child: Text(
                '\$ ${widget.activity.price}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
