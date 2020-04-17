
import 'package:flutter/cupertino.dart';

class CustomImageCliper extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height- 50);
    path.quadraticBezierTo(size.width/4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width *3/4, size.height, size.width, size.height -50);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }


}
class ClipShadowPath extends StatelessWidget{
  final Shadow shadow;
  final CustomImageCliper cliper;
  final Widget widget;

  const ClipShadowPath({Key key, this.shadow, this.cliper, this.widget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowPainter(shadow, cliper),
      child: ClipPath(
        child: widget,
        clipper: cliper,
      ),
    );
  }

}

class _ClipShadowPainter extends CustomPainter{

  final Shadow shadow;
  final CustomImageCliper cliper;

  _ClipShadowPainter(this.shadow, this.cliper);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = cliper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}