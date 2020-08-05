import 'dart:io';

import 'package:flutter/material.dart';

const String command_connect = 'CONNECT';
const String command_connected = 'CONNECTED';
const String command_message = 'MESSAGE';
const String command_send = 'SEND';
const String command_subscribe = 'SUBSCRIBE';
const String command_unsubscribe = 'UNSUBSCRIBE';
const String command_error = 'SOCKET_ERROR';
const String command_closed = 'SOCKET_CLOSED';

// Header constant
const String header_authorization = 'Authorization';
const String header_accept_version = 'accept-version';
const String header_device_id = 'device-id';
const String header_heart_beat = 'heart-beat';
const String header_destination = 'destination';
const String header_id = 'id';

// Key constant
const String key_command = 'command';
const String key_content = 'content';
const String key_subscription = 'subscription';

// Subscription name constant
const String subscription_name = 'mobile-';

class ChatWebSocket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatWebSocketHome(),
    );
  }
}

class ChatWebSocketHome extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ChatWebSocketHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat WebSocket'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                onConnect();
              },
              child: Text('Connect'),
            )
          ],
        ),
      ),
    );
  }

  onConnect() async {
    await initSocket();
  }

  static WebSocket _socket;

  initSocket() async {
    try {
      _socket = await WebSocket.connect('ws://157.119.251.218:9067/ws-ls');
      _socket.listen((ms) {
        print('Message  $ms');
        final data = _castData(ms);
        if (data == null) {
          return null;
        }
        print('Command: ${data[key_command]}');
      }, onError: (error, StackTrace stackTrace) {
        print('onError $error $stackTrace');
      });

//      if(_socket ==null ||_socket?.readyState == WebSocket.closing ||
//          _socket?.readyState == WebSocket.closed ){

    } on Exception catch (ex) {
      print('Exception $ex');
    }
  }

  _castData(String message) {
    final messageArray = message.split('\n');
    if (messageArray.isEmpty) {
      return null;
    }
    final data = {};
    //add message type
    data[key_command] = messageArray[0];
    for (var i = 1; i < messageArray.length - 1; i++) {
      final messageBody = messageArray[i].split(':');
      if (messageBody.length != 2) {
        continue;
      }
      data[messageBody[0]] = messageBody[1];
    }
    //add message content
    if (messageArray[messageArray.length - 1].isNotEmpty) {
      data[key_content] = messageArray[messageArray.length - 1];
    }
    return data;
  }
}
