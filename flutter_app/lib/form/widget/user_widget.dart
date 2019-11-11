import 'package:flutter/material.dart';

class UserItem extends StatefulWidget {
  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/user_default.png',
          fit: BoxFit.cover,),
          Positioned(
            top: 5,
            left: 5,
            child: Icon(Icons.message,color: Colors.blue,),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Icon(Icons.message,color: Colors.red,),
          )

        ],
      ),
    );
  }
}
