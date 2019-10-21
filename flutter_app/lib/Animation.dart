import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation demo',
      theme: ThemeData(primaryColor: Colors.purple),
      home: AnimationDemo(),
    );
  }
}

class AnimationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnimationState();
}

class AnimationState extends State<AnimationDemo>
    with TickerProviderStateMixin {
  AnimationController animationController;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Center(
        child: Container(
          child: FadeTransition(
            opacity: curvedAnimation,
            child: FlutterLogo(
              size: 200.0,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){animationController.forward();},
        child: Icon(Icons.update),
      ),
    );
  }
}
