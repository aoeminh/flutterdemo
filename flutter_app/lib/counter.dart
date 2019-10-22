import 'package:flutter/material.dart';


class CounterMain extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Counter Demo',
      theme: ThemeData(
        primaryColor: Colors.purple
      ),
      home: Counter(),
    );
  }

}
class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

   final int count;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('Count: $count');
  }
}

class CounterIncrement extends StatelessWidget {
  CounterIncrement({this.onPress});

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      onPressed: onPress,
      child: Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CounterState();
  }
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  _increas() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        CounterIncrement(onPress: _increas),
        CounterDisplay(count: _counter)
      ],
    );
  }
}
