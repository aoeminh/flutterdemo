import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RxHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RxDemo(),
    );
  }
}

class RxDemo extends StatefulWidget {
  @override
  _RxDemoState createState() => _RxDemoState();
}

class _RxDemoState extends State<RxDemo> {
  @override
  Widget build(BuildContext context) {
    test();

    return Scaffold(
      appBar: AppBar(
        title: Text('Rx demo'),
      ),
      body: Container(),
    );
  }

  test() {
   var obvs1 =  Observable(Stream.fromIterable(['assyrian', 'greek', 'hittle', 'shang', 'choson']))
        .interval(Duration(seconds: 1))
        .expand((item) => [item, item.substring(2)])
        .listen((data) {
//      print('$data');
   }).onData((data){
//     print('$data');
   });

   // chi in ra event gan nhat
   BehaviorSubject behaviorSubject = BehaviorSubject<String>();
   behaviorSubject.add('a');
   behaviorSubject.add('b');
   behaviorSubject.sink.add('c');
   behaviorSubject.listen((_){}).onData((print));


   // in ra event sau khi listen
  var publishSubject = PublishSubject<String>();
  publishSubject.add('1');
  publishSubject.add('2');
  publishSubject.listen(print);
  publishSubject.add('3');
  publishSubject.add('4');




  

  }
}
