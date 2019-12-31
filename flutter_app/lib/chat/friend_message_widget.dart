import 'package:flutter/material.dart';
import 'package:flutter_app/chat/message.dart';
import 'package:flutter_app/chat/text_style.dart';

import 'Util.dart';

const double maxWidthContent = 300;

class FriendMessage extends StatelessWidget {
  FriendMessage(this.message);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.person,
            size: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(message.userName, style: TextStyleUtil.textSecondaryGrey()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxWidthContent
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.lightBlueAccent),
                      child: Text(message.content),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(Util.convertTimeToString(message.time), style: TextStyleUtil.textSecondaryGrey())
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
