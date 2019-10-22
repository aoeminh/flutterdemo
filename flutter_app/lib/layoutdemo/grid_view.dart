import 'package:flutter/material.dart';

class GridDemo extends StatelessWidget {
  List<GestureDetector> _buildGridTileList(int count) => List.generate(
      count,
      (i) => GestureDetector(
            child: Container(child: CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage('assets/images/pic$i.jpg'),
            )),
            onTap: () => print('$i'),
          ));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Gridview demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gridview demo'),
        ),
        body: _buildGridView(),
      ),
    );
  }

  Widget _buildGridView() => GridView.extent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridTileList(9),
        padding: EdgeInsets.all(5),
      );
}
