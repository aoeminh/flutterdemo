import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Clip());
}

class Clip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClipHome(),
    );
  }
}

class ClipHome extends StatefulWidget {
  @override
  _ClipHomeState createState() => _ClipHomeState();
}

class _ClipHomeState extends State<ClipHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: ClipPath(
                clipper: CustomClipPath(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
                child: Container(
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(

              children: <Widget>[
                Expanded(
                  child: Icon(Icons.home,size: 30,),
                  flex: 2,
                ),
                Expanded(
                  child: Icon(Icons.home,size: 30),
                  flex: 2,
                ),
                Expanded(
                  child: Container(),
                  // child: Container(
                  //   width: 70,
                  //   height: 70,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Colors.white
                  //     ),
                  //     child: Icon(Icons.home,size: 50)),
                  flex: 2,
                ),
                Expanded(
                  child: Icon(Icons.home,size: 30),
                  flex: 2,
                ),
                Expanded(
                  child: Icon(Icons.home,size: 30),
                  flex: 2,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              width: 65,
              height: 65,
              child: Icon(
                Icons.live_tv,
                size: 35,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}

const double total = 11;

class CustomClipPath extends CustomClipper<Path> {
  double width;
  double height;

  CustomClipPath(this.width, this.height);

  @override
  getClip(Size size) {
    Path path = Path();
    // path.moveTo(0, size.height);
    // path.lineTo(0, size.height-50);
    // path.lineTo(size.width*3/11,size.height-50);
    // // path.lineTo(size.width*4/11,size.height-100);
    // path.quadraticBezierTo(size.width*7/22,size.height-50,size.width*9/22,size.height-67.5);
    //
    // path.quadraticBezierTo(size.width/2,size.height-90 ,size.width*13/22,size.height-67.5);
    // path.quadraticBezierTo(size.width*15/(total*2),size.height-50,size.width*8/total,size.height-50);
    // path.lineTo(size.width, size.height-50);
    //
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);

    path.moveTo(0, size.height);
    path.lineTo(0, size.height - 50);
    path.lineTo(size.width * 3 / 10, size.height - 50);
    // path.lineTo(size.width*4/11,size.height-100);
    path.quadraticBezierTo(size.width * 7 / 20, size.height - 50,
        size.width * 4 / 10, size.height - 67.5);

    path.quadraticBezierTo(size.width / 2, size.height - 100,
        size.width * 6 / 10, size.height - 67.5);
    path.quadraticBezierTo(size.width * 13 / 20, size.height - 50,
        size.width * 7 / 10, size.height - 50);
    path.lineTo(size.width, size.height - 50);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
