import 'package:flutter/material.dart';
import 'package:flutter_app/chat/friend_message_widget.dart';
import 'package:flutter_app/chat/message.dart';
import 'package:flutter_app/chat/owner_message_widget.dart';

class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messageList = dummyData() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: messageList.length,
          itemBuilder: (context, index){
        if(messageList[index].isOwner){
          return Container(
              alignment: Alignment.centerRight,child: OwnerMessage(messageList[index]));
        }else{
          return FriendMessage(messageList[index]);
        }
      }),
    );
  }

  static List<Message> dummyData() =>[
    Message(
      id: '1',
      content: 'Hello',
      isOwner: true,
      time: '5:43',
      userName: 'Minh'
    ),
    Message(
        id: '1',
        content: 'Hi',
        isOwner: false,
        time: '5:43',
        userName: 'Dung'
    ),
    Message(
        id: '1',
        content: 'How are you',
        isOwner: true,
        time: '5:43',
        userName: 'Minh'
    ),
    Message(
        id: '1',
        content: 'I\'m fine ',
        isOwner: false,
        time: '5:43',
        userName: 'Dung'
    ),
    Message(
        id: '1',
        content: 'Good',
        isOwner: true,
        time: '5:43',
        userName: 'Minh'
    )

  ];
}
