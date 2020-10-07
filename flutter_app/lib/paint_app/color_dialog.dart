import 'package:flutter/material.dart';

typedef  ChooseColor(color);
class ColorDialog extends StatefulWidget {
  final ChooseColor  chooseColor;
  final int colorIndex;
  const ColorDialog({Key key, this.chooseColor,this.colorIndex}) : super(key: key);
  @override
  _ColorDialogState createState() => _ColorDialogState();
}

class _ColorDialogState extends State<ColorDialog> {
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    currentIndex =widget.colorIndex;
  }
  @override
  Widget build(BuildContext context) {
    print('_ColorDialogState');
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, mainAxisSpacing: 15, crossAxisSpacing: 15),
                itemCount: listColor.length,
                itemBuilder: (context, index) {
                  return _itemColor(listColor[index]);
                }),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _itemColor(Color color) => InkWell(
        onTap: () {
          setState(() {
            currentIndex = listColor.indexOf(color);
            widget.chooseColor(color);
          });
        },
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Center(
            child: currentIndex == listColor.indexOf(color)
                ? Icon(
                    Icons.check,
                    color: color == Colors.black ? Colors.white : Colors.black,
                  )
                : Container(),
          ),
        ),
      );


}
List<Color> _listColor() => [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.purple,
  Colors.pink,
  Colors.black,
];

  List<Color> get listColor => _listColor();