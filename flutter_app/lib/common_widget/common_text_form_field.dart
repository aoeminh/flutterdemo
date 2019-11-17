import 'package:flutter/material.dart';

typedef OnValidator(String value);
typedef OnChange(String value);
typedef OnClick();

class CommonTextFormField extends StatelessWidget {
  CommonTextFormField(
      {this.prefixIcon,
      this.hintText,
      this.action,
      this.validator,
      this.inputType,
      this.inputController,
      this.onChange,
      this.onClick});

  final prefixIcon;
  final hintText;
  final action;
  final inputType;
  final TextEditingController inputController;
  final OnValidator validator;
  final OnChange onChange;
  final OnClick onClick;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? prefixIcon : Icon(Icons.person),
        hintText: hintText != null ? hintText : '',
      ),
      textInputAction: action != null ? action : TextInputAction.next,
      validator: validator,
      keyboardType: inputType != null ? inputType : TextInputType.text,
      onChanged: onChange,
      onTap: onClick,
    );
  }
}
