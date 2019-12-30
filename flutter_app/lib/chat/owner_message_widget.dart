import 'package:flutter/material.dart';
import 'package:flutter_app/chat/message.dart';

class OwnerMessage extends StatelessWidget {
  OwnerMessage(this.message);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[

        Text(message.time),
        Container(
          padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.green),
          child: Text(message.content),
        ),
      ],
    );
  }
}
