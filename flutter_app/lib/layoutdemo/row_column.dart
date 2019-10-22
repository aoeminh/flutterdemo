import 'package:flutter/material.dart';

class RowColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Row and Column',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Row and Column'),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0,40,0,30),
            height: 600,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Container(
                  width: 240,
                  child: leftColumn(),
                ),
                rightImage(),
              ]
            ),
          )
        ),
      ),
    );
  }

  Widget buildRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/images/pic1.jpg'),
          Image.asset('assets/images/pic2.jpg'),
          Image.asset('assets/images/pic3.jpg'),
        ],
      );

  Widget buildColumn() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/images/pic1.jpg'),
          Image.asset('assets/images/pic2.jpg'),
          Image.asset('assets/images/pic3.jpg'),
        ],
      );

  Widget buildRowCrossExpand() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Image.asset('assets/images/pic1.jpg'),
          ),
          Expanded(
            child: Image.asset('assets/images/pic2.jpg'),
          ),
          Expanded(
            flex: 2,
            child: Image.asset('assets/images/pic3.jpg'),
          ),
          Expanded(
            child: Image.asset('assets/images/pic2.jpg'),
          ),
          Expanded(
            child: Image.asset('assets/images/pic3.jpg'),
          ),
        ],
      );

  Widget mainRow() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          leftColumn(),
          rightImage(),
        ],
      );

  Widget leftColumn() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          titleText(),
          descritionText(),
          ratingRow(),
          iconList(),
        ],
      );

  Widget titleText() => Text(
        'Strawberry',
        style: titleTextStyle,
      );

  final descTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 18,
    height: 2,
  );

  final titleTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w900,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 20,
    height: 1,
  );

  Widget descritionText() => Text(
        'This is Strawberry. It is fresh.',
        style: descTextStyle,
      );

  Widget rightImage() => Expanded(
      child: Image.asset('assets/images/pic3.jpg',fit: BoxFit.cover,));

  Widget ratingRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[starRow(), Text('178 reviews')],
      );

  Widget starRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.black,
          ),
          Icon(
            Icons.star,
            color: Colors.black,
          ),
        ],
      );

  iconList() => DefaultTextStyle.merge(
      style: descTextStyle,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(
                  Icons.kitchen,
                  color: Colors.green,
                ),
                Text('Prep'),
                Text('25 min'),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  color: Colors.green,
                ),
                Text('Cook'),
                Text('1h'),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.restaurant,
                  color: Colors.green,
                ),
                Text('Feeds'),
                Text('4-6'),
              ],
            ),
          ],
        ),
      ));
}
