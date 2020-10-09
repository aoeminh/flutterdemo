
import 'package:flutter/material.dart';
import 'dart:math' as math;
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
        value: 0.0, vsync: this, duration: Duration(seconds: 5),
    upperBound: 1,
    lowerBound: -1
    )
     ..repeat() ;
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

  var  valueY = 0.0;
  var slice = math.pi;

  @override
  Path getClip(Size size) {
    double xCenter = size.width *0.5 +(size.width *0.6 + 1 )  * math.sin(valueY * slice);
    double yCenter = size.height *0.8 +150  * math.cos(valueY * slice);
    Path path = Path();
    Offset startPoint = Offset(0, size.height * 0.7);
    print('width ${size.width}');
    path.lineTo(startPoint.dx, startPoint.dy);
    path.quadraticBezierTo(
        xCenter,yCenter, size.width, size.height * 0.7);
    path.lineTo(startPoint.dy, size.width);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
