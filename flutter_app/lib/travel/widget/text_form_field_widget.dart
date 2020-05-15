import 'package:flutter/material.dart';

const Color hintTextColors = Colors.white54;
const Color whiteTextColors = Colors.white;
class TextFormFieldWidget extends StatelessWidget {

  final String hintText;
  final FocusNode focusNode;
  final FormFieldSetter<String> onSave;
  final FormFieldValidator<String> onValidate;
  final TextInputAction textInputAction;
  final bool obscureText;
  final ValueChanged<String> onFieldSubmitted;

  TextFormFieldWidget({this.hintText, this.focusNode,
      this.onSave, this.onValidate,this.textInputAction,this.obscureText,this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: hintTextColors)),
          focusedBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: Colors.white)),
          hintText: hintText,
          hintStyle: TextStyle(color: hintTextColors)),
      obscureText: obscureText?? false,
      textInputAction: textInputAction,
      style: TextStyle(color: whiteTextColors),
      cursorColor: Colors.white,
      focusNode: focusNode?? FocusNode(),
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSave,
      validator: onValidate,
    );

  }
}
