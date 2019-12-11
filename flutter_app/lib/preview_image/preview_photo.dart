import 'package:flutter/material.dart' ;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as s;

class PreviewImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PreviewImageDemo());
  }
}

class PreviewImageDemo extends StatefulWidget {

  @override
  test createState() => test();
}

class test extends State<PreviewImageDemo> {
  double _scale = 0.0;
  double _previousScale = 0.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Image'),)
      ,
      body: Transform(
        transform: Matrix4.diagonal3(new s.Vector3(_scale,_scale, _scale)),
        origin: Offset(50.0, 50.0),
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.blue,
          child: Image.network(
                  'https://img.saobiz.net/d/2015/07/hinh-anh-dep-ve-thien-nhien-cay-coi.jpg'),
        ),
      ),);
  }
}

//class _PreviewImageDemoState extends State<PreviewImageDemo> {
//double _scale = 0.0;
//
//double _previousScale = 0.0;
//
//@override
//Widget build(BuildContext context) {
//  // TODO: implement build
//  return Scaffold(
//    appBar: AppBar(
//      title: Text('Preview Image'),
//    ),
//    body: GestureDetector(
//        onScaleStart: (ScaleStartDetails detail){
//          print(detail);
//          _previousScale = _scale;
//        },
//        onScaleUpdate: (ScaleUpdateDetails detail){
//          print(detail);
//          setState(() => _scale = _previousScale * detail.scale);
//        },
//
//        onScaleEnd:  (ScaleEndDetails details){
//          print(details);
//          // See comment above
//          _previousScale = null;
//        },
////        child: Transform.scale(
//////          transform: new Matrix4.diagonal3(new Vector3(_scale, _scale, _scale)),
////          scale: _scale,
////          child: Container(
////
////            child: Center(
////              child: Image.network(
////                  'https://img.saobiz.net/d/2015/07/hinh-anh-dep-ve-thien-nhien-cay-coi.jpg'),
////            ),
////          ),
////        ),
//        child: Container(
//          child: Transform(
//            alignment: Alignment.topRight,
//            transform: Matrix4.skewY(0.3)..rotateZ(20 / 12.0),
//            child: Container(
//              padding: const EdgeInsets.all(8.0),
//              color: const Color(0xFFE8581C),
//              child: const Text('Apartment for rent!'),
//            ),
//          ),
//        )
////
//    ),
//  );
//}
//}
