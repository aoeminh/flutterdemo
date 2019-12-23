import 'package:flutter/material.dart';

class ParentingAnimationWidgetHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ParentingAnimationWidget(),
    );
  }
}

class ParentingAnimationWidget extends StatefulWidget {
  @override
  _ParentingAnimationWidgetState createState() =>
      _ParentingAnimationWidgetState();
}

class _ParentingAnimationWidgetState extends State<ParentingAnimationWidget>
    with TickerProviderStateMixin {
  Animation _growAnimation;
  Animation _animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _growAnimation = Tween(begin: 10, end: 100)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    _animation = Tween(begin: -0.25, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }

            if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('ParentingAnimation'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Transform(
                  transform: Matrix4.translationValues(
                      _animation.value * width, 0.0, 0.0),
                  child: Center(
                      child: AnimatedBuilder(
                        animation: _growAnimation,
                        builder: (BuildContext context, Widget child) {
                          return new Center(
                              child: Container(
                                height: _growAnimation.value,
                                width: _growAnimation.value * 2,
                                color: Colors.black12,
                              ));
                        },
                      ))),
              Transform(
                transform: Matrix4.translationValues(
                    _animation.value * width, 0.0, 0.0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.orange,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
