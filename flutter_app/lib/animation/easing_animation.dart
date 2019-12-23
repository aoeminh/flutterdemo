import 'package:flutter/material.dart';

class EasingAnimationWidgetHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EasingAnimationWidget(),
    );
  }
}

class EasingAnimationWidget extends StatefulWidget {
  @override
  _EasingAnimationWidgetState createState() => _EasingAnimationWidgetState();
}

class _EasingAnimationWidgetState extends State<EasingAnimationWidget>
    with TickerProviderStateMixin {
  Animation _animation;
  Animation _lateAnimation;
  AnimationController _controller;
  double width;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn))
      ..addStatusListener(handler);

    _lateAnimation = Tween(begin: -1.0, end: 1.0).animate(
        (CurvedAnimation(parent: _controller, curve: Interval(
            0.0, 0.5
        ))));
    _controller.forward();

//    _controller =
//        AnimationController(vsync: this, duration: Duration(seconds: 2));
//    _animation = Tween(begin: -1.0, end: 1.0).animate(
//        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
//
//
//    _controller.addListener((){
//      if(_controller.isCompleted){
//        print('controller.isCompleted');
//        _controller.reverse();
//      }else if(_controller.isDismissed){
//        _controller.forward();
//        print('controller.isDismissed');
//      }
//    });
    _controller.forward();
  }

  handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(handler);
      _controller.reset();
//      _animation = Tween(begin: 0.0, end: 1.0).animate(
//          CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
      _lateAnimation = Tween(begin: 0.0, end: 1.0).animate(
          (CurvedAnimation(parent: _controller, curve: Interval(
              0.0, 0.5
          ))))..addStatusListener((status){
            if(status == AnimationStatus.completed){
//              _controller.reverse();
            }
      });
      _controller.forward();

    }
  }


  @override
  Widget build(BuildContext context) {
    print('build');
    width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Easing Animation'),
      ),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Transform(
              transform:
              Matrix4.translationValues(_lateAnimation.value * width, 0.0, 0.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.green,
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
