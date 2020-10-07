import 'package:flutter/material.dart';

typedef ChooseBrush(double stroke, int index);

class BrushDialog extends StatefulWidget {
  final Color color;
  final int brushIndex;
  final ChooseBrush chooseBrush;

  const BrushDialog({Key key, this.color, this.brushIndex, this.chooseBrush})
      : super(key: key);

  @override
  _BrushDialogState createState() => _BrushDialogState();
}

class _BrushDialogState extends State<BrushDialog> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.brushIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
                itemCount: listStroke.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return _itemBrush(listStroke[index], index);
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
          )
        ],
      ),
    );
  }

  _itemBrush(double stroke, int index) => InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
            widget.chooseBrush(stroke, index);
          });
        },
        child: Container(
          padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                    color: currentIndex == index
                        ? Colors.red
                        : Colors.transparent)),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.all(Radius.circular(stroke))
                ),
                height: stroke,

              ),
            )),
      );

  List<double> _listStroke() => [3.0, 6.0, 9.0, 12.0, 15.0];

  List<double> get listStroke => _listStroke();
}
