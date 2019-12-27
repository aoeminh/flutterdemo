import 'package:flutter/material.dart';

const double _margin = 5;

class CategoryWidget extends StatefulWidget {
  CategoryWidget({this.icon, this.title, this.isSelected});

  final icon;
  final title;
  final isSelected;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    double itemsWidth = (MediaQuery.of(context).size.width - _margin * 8) / 4.5;

    var theme = Theme.of(context);
    return Container(
      height: itemsWidth,
      width: itemsWidth,
      margin: EdgeInsets.all(_margin),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: widget.isSelected ? Colors.white : theme.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white,width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            widget.icon,
            color: widget.isSelected ? Color(0xFFFF4700) : Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 16,
                color: widget.isSelected ? Color(0xFFFF4700) : Colors.white),
          )
        ],
      ),
    );
  }
}
