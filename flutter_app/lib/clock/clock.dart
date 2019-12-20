import 'package:flutter/material.dart';

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClockHome(),
    );
  }
}

class ClockHome extends StatefulWidget {
  @override
  _ClockHomeState createState() => _ClockHomeState();
}

class _ClockHomeState extends State<ClockHome>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else if (animationController.isDismissed) {
        animationController.forward();
      }
      setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animation = Tween(begin: -0.5, end: 0.5).animate(animation);
    return Scaffold(
      appBar: AppBar(
        title: Text('Clock'),
      ),
      body: _body(),
    );
  }

  _body() => Container(

        color: Colors.deepOrange,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _clock(),
            SizedBox(
              height: 10,
            ),
            Transform(
              alignment: FractionalOffset(0.5,0),
              transform: Matrix4.rotationZ(animation.value),
              child: Image.asset(
                'assets/images/pandulum.png',
                width: 150,
                height: 250,

              ),
            )
          ],
        ),
      );

  _clock() => Container(

        width: 320,
        height: 320,
        decoration: BoxDecoration(
          color: Colors.brown.shade900,
          borderRadius: BorderRadius.all(Radius.circular(30)),

        ),
        child: Center(
          child: Text(
            getCurrentTime(),
            style: TextStyle(
                fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );

  String getCurrentTime() {
    int hour = DateTime.now().hour;
    int minute = DateTime.now().minute;
    int second = DateTime.now().second;
    return '$hour : $minute : $second';
  }
}
