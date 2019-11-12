import 'package:flutter/material.dart';

const double mPadding = 10;

// save value
typedef OnSave(String value);

class InputForm extends StatelessWidget {
  InputForm({this.focusNode,this.nextFocusNode, this.hintText, this.action, this.onSave,this.obscureText});

  final focusNode;
  final hintText;
  final TextInputAction action;
  final nextFocusNode;
  final OnSave onSave;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      obscureText: obscureText != null ? obscureText : false,
      focusNode: focusNode != null ? focusNode : FocusNode(),
      decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.amberAccent),
              borderRadius: BorderRadius.circular(50)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(50)),
          contentPadding:
              EdgeInsets.only(left: mPadding, top: mPadding, bottom: mPadding),
          hintText: hintText),
      onSaved: onSave,
      textInputAction: action != null ? action : TextInputAction.next,
      onFieldSubmitted: (v) => {FocusScope.of(context).requestFocus(nextFocusNode != null ? nextFocusNode : FocusNode)},
    );
    ;
  }
}
