import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
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

class BlocDemo1 extends StatelessWidget {
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
    //geeting the instance of our model created at Parent
    colorBloc = BlocProvider.of(context);
    return Column(
      children: <Widget>[
        Container(
          child: StreamBuilder(
            initialData: Colors.red,
            stream: colorBloc.colorStream,
            builder: (BuildContext context, snapShot) => Center(
              child: Container(
                height: 200.0,
                width: 200.0,
                color: snapShot.data,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Child2 extends StatelessWidget {
  ColorBloc colorBloc;
  @override
  Widget build(BuildContext context) {
    colorBloc = BlocProvider.of(context);
    return Column(
      children: <Widget>[
        Container(
          child: Center(
            child: RaisedButton(
              child: Text("Change Color"),
              color: Colors.blue,
              onPressed: () {
                colorBloc.changeColor();
              },
            ),
          ),
        ),
      ],
    );
  }
}