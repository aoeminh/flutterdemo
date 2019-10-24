import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {

  BlocProvider({@required this.child, @required this.bloc});

  final Widget child;
  final T bloc;

  @override
  _BlockProviderState<T> createState() {
    return _BlockProviderState<T>();
  }

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_BlockProviderInherited<T>>();
    _BlockProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlockProviderState<T extends BlocBase> extends State<BlocProvider> {
  @override
  void dispose() {
    widget?.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _BlockProviderInherited(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlockProviderInherited<T> extends InheritedWidget {
  _BlockProviderInherited({@required Widget child, @required this.bloc});

  final T bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }
}

class ColorBloc extends BlocBase {
// streams of Color
  StreamController streamListController = StreamController<Color>.broadcast();

// sink
  Sink get colorSink => streamListController.sink;

// stream
  Stream<Color> get colorStream => streamListController.stream;

// function to change the color
  changeColor() {
    colorSink.add(getRandomColor());
  }

//disponsing our Stream
  @override
  dispose() {
    streamListController.close();
  }
}

// Random Colour generator
Color getRandomColor() {
  Random _random = Random();
  return Color.fromARGB(
      255, _random.nextInt(256), _random.nextInt(256), _random.nextInt(256));
}

class BlocProviderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text(
          "BLoC Architecture",
        )),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: BlocProvider(
              bloc: ColorBloc(),
              child: Column(
                children: <Widget>[
                  Child1(),
                  Child2(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Child1 extends StatelessWidget {
  ColorBloc colorBloc;

  @override
  Widget build(BuildContext context) {
    colorBloc = BlocProvider.of(context);
    // TODO: implement build
    return StreamBuilder(
      initialData: Colors.red,
      stream: colorBloc.colorStream,
      builder: (BuildContext context, snapShot) => Center(
        child: Container(
          width: 200,
          height: 200,
          color: snapShot.data,
        ),
      ),
    );
  }
}

class Child2 extends StatelessWidget {
  ColorBloc colorBloc;

  @override
  Widget build(BuildContext context) {
    colorBloc = BlocProvider.of(context);
    return RaisedButton(
      child: Text('Change color'),
      color: Colors.green,
      onPressed: colorBloc.changeColor(),
    );
  }
}
