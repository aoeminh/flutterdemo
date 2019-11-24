import 'dart:ui';

import 'package:flutter/material.dart';

class Style{

  static TextStyle whiteTextWhiteNormal(){
    return TextStyle(
      color: Colors.white,
      fontSize: 15
    );
  }

  static TextStyle whiteTextWhiteNormalBold(){
    return TextStyle(
        color: Colors.white,
        fontSize: 15,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle whiteTextBigBold(){
    return TextStyle(
        color: Colors.white,
        fontSize: 30
    );
  }
}