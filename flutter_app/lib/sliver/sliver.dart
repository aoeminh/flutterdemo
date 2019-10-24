import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_with_inherited_widget.dart';

class SliverDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sliver Demo'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              sliverAppbar(),
              sliverGrid(),

              sliverList(),

            ],
          ),
        ),
      ),
    );
  }

  Widget sliverList() => SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            // To convert this infinite list to a list with three items,
            // uncomment the following line:
            return Container(color: getRandomColor(), height: 150.0);
          },
          // Or, uncomment the following line:,

          childCount: 10,
        ),

      );

  Widget sliverGrid() => SliverGrid(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          height: 150,
          color: getRandomColor(),
        );
      }, childCount: 60));

  Widget sliverAppbar() => SliverAppBar(
        backgroundColor: Colors.green,
        expandedHeight: 200.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.asset('assets/images/pic1.jpg', fit: BoxFit.cover),
        ),
      );
}
