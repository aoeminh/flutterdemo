import 'package:web_socket_channel/io.dart';

class WebSocket {
  WebSocket._internal();

  // make singleton

  static final _webSocket = WebSocket._internal();
  List<Function> _listener = List<Function>();

  factory WebSocket() {
    return _webSocket;
  }

  IOWebSocketChannel _channel;

  connect() {
    _channel =
        IOWebSocketChannel.connect('wss://mkp-www-01.itsherpa.net/cas/ws/');
    _channel.stream.listen(_receiveMessage);
  }

  addListener(Function callback) {
    _listener.add(callback);
  }

  _receiveMessage(message) {
    _listener.forEach((Function callback) {
      callback(message);
    });
  }

  send(String message){
    if(_channel !=null && _channel.sink != null){
      _channel.sink.add(message);
    }
  }
}
