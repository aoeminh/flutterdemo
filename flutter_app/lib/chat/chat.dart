import 'package:flutter/material.dart';
import 'package:flutter_app/chat/chat_page.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatHome(),
    );
  }
}

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              setState(() {
                isShow = !isShow;
              });
            },
            child: Icon(Icons.message)),
      ),
      body: SafeArea(
        child: Stack(children: <Widget>[
          Container(
//          height: 2000,
            color: Colors.green,
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPage()));
              },
              child: Offstage(
                offstage: !isShow,
                child: Container(
                  height: 300,
                  width: 200,
                  color: Colors.orange,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
