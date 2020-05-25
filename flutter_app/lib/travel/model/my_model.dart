import 'dart:core';

import 'package:flutter/cupertino.dart';

import 'travel.dart';

class MyModel extends ChangeNotifier {
  List<Travel> _travels = [];

  List<Travel> get travels => _travels;

  setTravel(Travel travel) {
    this._travels.add(travel);
    notifyListeners();
  }

  editTravel(int index, Travel travel) {
    _travels[index] = travel;
    notifyListeners();
  }

  addListTravel(List<Travel> list) {
    this._travels = list;
    notifyListeners();
  }

}
