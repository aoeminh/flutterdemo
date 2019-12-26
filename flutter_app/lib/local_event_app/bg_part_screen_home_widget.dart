
import 'package:flutter/material.dart';
import 'dart:math';
class BackgroundPartHomePage extends StatefulWidget {
  BackgroundPartHomePage({@required this.height, this.width});

  final height;
  final width;

  @override
  _BackgroundPartHomePageState createState() => _BackgroundPartHomePageState();
}

class _BackgroundPartHomePageState extends State<BackgroundPartHomePage>
    with TickerProviderStateMixin {
  Animation animation;

  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        value: 0.0, vsync: this, duration: Duration(seconds: 2),
    upperBound: 1,
    lowerBound: -1)
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return ClipPath(
          clipper: BottomShapeClipper(controller.value),
          child: Container(
            height: widget.height * 0.5,
            color: themeData.primaryColor,
          ),
        );
      },
    );
  }
}

class BottomShapeClipper extends CustomClipper<Path> {
  BottomShapeClipper(this.valueY);

  var  valueY = 9.0;
  var slice = math.pi;

  @override
  Path getClip(Size size) {
    double xCenter = size.width *0.5 * math.sin;
    Path path = Path();
    Offset startPoint = Offset(0, size.height * 0.7);
    Offset endPoint = Offset(size.width, size.height * 0.7);
    Offset controlPoint = Offset(size.width / 2, size.height);

    path.lineTo(startPoint.dx, startPoint.dy);
    path.quadraticBezierTo(
        controlPoint.dx, valueY, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
