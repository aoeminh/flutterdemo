import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorUtils {
  static Color _intToColor(int hexNumber) => Color.fromARGB(
      255,
      (hexNumber >> 16) & 0xFF,
      ((hexNumber >> 8) & 0xFF),
      (hexNumber >> 0) & 0xFF);

  /// String To Material color
  static Color stringToColor(String hex) =>
      _intToColor(int.parse(_textSubString(hex), radix: 16));

//Substring
  static String _textSubString(String text) {
    if (text == null) return null;

    if (text.length < 6) return null;

    if (text.length == 6) return text;

    return text.substring(1, text.length);
  }

  /// The method that create a LinearGradient object
  static LinearGradient create(
    double angle,
    List<Color> colors,
    List<double> stops,
    TileMode tileMode,
  ) =>
      LinearGradient(
        colors: colors,
        stops: stops,
        tileMode: tileMode,
        transform: GradientRotation(50),
      );

  static LinearGradient linear(
    List<Color> colors,
  ) =>
      create(
        0.0,
        colors,
        [0.0, 1.0],
        TileMode.clamp,
      );

  static List<Gradient> listColorGradient = ItemColor.listItemColor
      .map((itemColor) => linear([
            stringToColor(itemColor.primaryColor),
            stringToColor(itemColor.accentColor)
          ]))
      .toList();

}

class ItemColor {
  String primaryColor;
  String accentColor;

  ItemColor(this.primaryColor, this.accentColor);

  static List<ItemColor> listItemColor = [
    ItemColor('#4facfe', '#00f2fe'),
    ItemColor('#868f96', '#596164'),
    ItemColor('#df89b5', '#bfd9fe'),
    ItemColor('#4481eb', '#04befe'),
    ItemColor('f9d423', '#ff4e50'),
    ItemColor('f6d365', '#fda085'),
  ];
}
