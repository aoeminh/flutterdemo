import 'dart:ui';

import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/paint_app/brush_dialog.dart';
import 'package:flutter_app/paint_app/color_dialog.dart';
import 'package:rxdart/rxdart.dart';

double opacity = 1.0;
StrokeCap strokeType = StrokeCap.round;
double strokeWidth = 3.0;

void main() {
  runApp(PainHome());
}

class PainHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PaintApp());
  }
}

class PaintApp extends StatefulWidget {
  @override
  _PaintAppState createState() => _PaintAppState();
}

class _PaintAppState extends State<PaintApp> {
  List<TouchPoint> points = List();
  Color currentColor = Colors.black;
  double currentStroke = 0;
  BehaviorSubject<List<TouchPoint>> touchPointSubject = BehaviorSubject();
  int currentColorIndex = 0;
  int currentBrushIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    touchPointSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text("Painter App"),
        actions: <Widget>[
          InkWell(
            onTap: () {
              points.clear();
            },
            child: Container(
                margin: EdgeInsets.only(right: 20), child: Icon(Icons.clear)),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: GestureDetector(
          onPanDown: (detail) {
            print('ongPaint down');
            points.add(TouchPoint(
              paint: Paint()
                ..strokeCap = strokeType
                ..isAntiAlias = true
                ..color = currentColor.withOpacity(opacity)
                ..strokeWidth = currentStroke,
              points: detail.localPosition,
            ));

            touchPointSubject.add(points);
          },
          onPanUpdate: (detail) {
            print('onPanUpdate ');
            points.add(TouchPoint(
              paint: Paint()
                ..strokeCap = strokeType
                ..isAntiAlias = true
                ..color = currentColor.withOpacity(opacity)
                ..strokeWidth = currentStroke,
              points: detail.localPosition,
            ));
            touchPointSubject.add(points);
          },
          onPanEnd: (detail) {
            points.add(null);
            touchPointSubject.add(points);
          },
          child: StreamBuilder(
              stream: touchPointSubject.stream,
              builder: (context, snapshot) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: MyPainter(pointsList: points),
                );
              }),
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: listButton(),
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.red,
        animatedIconData: AnimatedIcons.menu_close,
      ),
    );
  }

  List<Widget> listButton() => [
        FloatingActionButton(
          child: Icon(Icons.brush),
          tooltip: 'Choose brush',
          onPressed: _chooseBrushDialog,
        ),
        FloatingActionButton(
          child: Icon(Icons.opacity),
          tooltip: 'Choose opacity',
          onPressed: () {},
        ),
        FloatingActionButton(
            child: Icon(Icons.color_lens),
            tooltip: 'Choose color',
            onPressed: _chooseColorDialog),
        FloatingActionButton(
          child: Icon(Icons.colorize),
          tooltip: 'Choose eraser',
          onPressed: () {
            currentColor = Colors.white;
          },
        ),
        FloatingActionButton(
          child: Icon(Icons.clear),
          tooltip: 'Clear all',
          onPressed: () {
            points.clear();
          },
        ),
      ];

  _chooseColorDialog() {
    print('_chooseColorDialog');
    showDialog(
        context: context,
        builder: (context) => ColorDialog(
              colorIndex: currentColorIndex,
              chooseColor: (color) {
                currentColor = color;
                currentColorIndex = listColor.indexOf(color);
              },
            ));
  }

  _chooseBrushDialog() {
    showDialog(
        context: context,
        builder: (context) => BrushDialog(
          color: currentColor,
          brushIndex: currentColorIndex,
          chooseBrush: (stroke,index) {
            currentStroke = stroke;
            currentColorIndex = index;
          },
        ));
  }
}



class MyPainter extends CustomPainter {
  final List<TouchPoint> pointsList;

  MyPainter({this.pointsList});

  List<Offset> offsetPoints = List();

  @override
  void paint(Canvas canvas, Size size) {
    print('pain ${pointsList.length}');

    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        //Drawing line when two consecutive points are available
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        //Draw points when two points are not next to each other
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TouchPoint {
  final Offset points;
  final Paint paint;

  TouchPoint({this.points, this.paint});
}
