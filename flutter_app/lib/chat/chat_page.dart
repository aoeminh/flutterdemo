import 'package:flutter/material.dart';
import 'package:flutter_app/chat/friend_message_widget.dart';
import 'package:flutter_app/chat/message.dart';
import 'package:flutter_app/chat/owner_message_widget.dart';
import 'package:flutter_app/chat/share_preferent.dart';

const int saveSize = 50;
const double _paddingHorizontalTextField = 10;
const double _heightInput = 50;
const double _sendIconSize = 30;

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
    getList();
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
    // save list message to local
    if (messageList.isNotEmpty) {
      if (messageList.length <= saveSize) {
        await MessagePreferences.saveListMessage(messageList);
      } else {
        await MessagePreferences.saveListMessage(
            messageList.sublist(messageList.length - saveSize));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[_listMessage(), _inputMessage()],
        ),
      ),
    );
  }

  _listMessage() => Expanded(
        child: messageList.length == 0
            ? _emptyMessage()
            : ListView.builder(
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

  _emptyMessage() => Container();

  _inputMessage() => Container(
        height: _heightInput,
        color: Color(0xFFD6D6D6),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: _paddingHorizontalTextField),
                    child: TextField(
                      controller: _controller,
                      focusNode: focusNode,
                    ))),
            InkWell(
              onTap: _actionSend,
              child: Icon(
                Icons.send,
                color: Colors.lightBlue,
                size: _sendIconSize,
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
          id: '2');
      addItem(message);
      _scrollToEnd();
      _controller.clear();
    }
  }

  addItem(Message message) {
    messageList.add(message);
    setState(() {});
  }

  getList() {
    MessagePreferences.getListMessage().then((list) {
      if (list != null && list.isNotEmpty) {
        messageList.addAll(list);
        _scrollToEnd();
      }
      setState(() {});
    });
  }

  _scrollToEnd() {
    Future.delayed(Duration(milliseconds: 200), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }
}
