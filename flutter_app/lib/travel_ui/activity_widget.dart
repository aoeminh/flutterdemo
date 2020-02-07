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
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.asset(widget.activity.imageUrl,fit: BoxFit.cover,),
          ),
          Expanded(
            flex: 2,
            child: Column(


            ),
          )
        ],
      ),
    );
  }
}
