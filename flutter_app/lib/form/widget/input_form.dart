import 'package:flutter/material.dart';

const double mPadding = 10;

// save value
typedef OnSave(String value);

class InputForm extends StatelessWidget {
  InputForm({this.focusNode, this.isForcus, this.hintText, this.onSave});

  final bool isForcus;
  final focusNode;
  final hintText;
  final OnSave onSave;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 1, color: isForcus ? Colors.amberAccent : Colors.grey),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        focusNode: focusNode,

        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(
                left: mPadding, top: mPadding, bottom: mPadding),
            hintText: hintText),
        onSaved: onSave,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) =>
            {FocusScope.of(context).requestFocus(focusNode)},
      ),
    );
    ;
  }
}
