import 'package:flutter/material.dart';
import 'package:flutter_app/chat/friend_message_widget.dart';
import 'package:flutter_app/chat/message.dart';
import 'package:flutter_app/chat/owner_message_widget.dart';
import 'package:flutter_app/chat/share_preferent.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messageList = List<Message>();

  TextEditingController _controller;
  ScrollController _scrollController;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });
    _scrollController = ScrollController();
    _controller = TextEditingController();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getList();
    print('build');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[_listMessage(), _inputMessage()],
        ),
      ),
    );
  }

  _listMessage() => Expanded(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              if (messageList[index].isOwner) {
                return OwnerMessage(messageList[index]);
              } else {
                return FriendMessage(messageList[index]);
              }
            }),
      );

  _inputMessage() => Container(
        height: 50,
        color: Color(0xFFD6D6D6),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _controller,
                      focusNode: focusNode,
                    ))),
            InkWell(
              onTap: _actionSend,
              child: Icon(
                Icons.send,
                color: Colors.lightBlue,
                size: 30,
              ),
            ),
            SizedBox(
              width: 5,
            )
          ],
        ),
      );

  _actionSend() async {
    if (_controller.text.isNotEmpty) {
      String content = _controller.text;
      Message message = Message(
          userName: 'Dung',
          time: DateTime.now().millisecondsSinceEpoch,
          isOwner: true,
          content: content,
          id: '1');
      addItem(message);

      Future.delayed(Duration(milliseconds: 200), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      });
      _controller.clear();
    }
  }

  addItem(Message message) async {
    messageList.add(message);
    setState(() {});
    MessagePreferences.saveListMessage(messageList);
  }

  getList()async{
    final list =await MessagePreferences.getListMessage();
    messageList.addAll(list);
    print('${messageList[0].userName}');

  }

  static List<Message> dummyData() => [
        Message(
            id: '1',
            content: 'Hello',
            isOwner: true,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Minh'),
        Message(
            id: '1',
            content: 'Hi',
            isOwner: false,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Dung'),
        Message(
            id: '1',
            content:
                'How are you How are you ',
            isOwner: true,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Minh'),
        Message(
            id: '1',
            content:
                'I\'m fine I\'m fine ',
            isOwner: false,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Dung'),
        Message(
            id: '1',
            content: 'Good',
            isOwner: true,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Minh'),
        Message(
            id: '1',
            content: 'Hello',
            isOwner: true,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Minh'),
        Message(
            id: '1',
            content: 'Hi',
            isOwner: false,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Dung'),
        Message(
            id: '1',
            content:
                'How are you How are you ',
            isOwner: true,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Minh'),
        Message(
            id: '1',
            content:
                'I\'m fine I\'m fine I\'m fine  ',
            isOwner: false,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Dung'),
        Message(
            id: '1',
            content: 'Good',
            isOwner: true,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Minh'),
        Message(
            id: '1',
            content: 'Hello',
            isOwner: true,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Minh'),
        Message(
            id: '1',
            content: 'Hi',
            isOwner: false,
            time:  DateTime.now().millisecondsSinceEpoch,
            userName: 'Dung'),
      ];
}
