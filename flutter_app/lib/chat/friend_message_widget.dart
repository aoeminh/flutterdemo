import 'package:flutter/material.dart';
import 'package:flutter_app/chat/message.dart';

class FriendMessage extends StatelessWidget {
  FriendMessage(this.message);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.person,
            size: 50,
          ),
          Column(
            children: <Widget>[
              Text(message.userName),
              Container(
                padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.lightBlueAccent),
                child: Text(message.content),
              )
            ],
          )
        ],
      ),
    );
  }
}
