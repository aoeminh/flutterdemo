import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/travel/model/travel.dart';

class MyModel extends ChangeNotifier {
  List<Travel> travels = [];



  setTravel(Travel travel) {

    this.travels.add(travel);
    notifyListeners();
  }

  editTravel(int index, Travel travel){
    travels[index] = travel;
    notifyListeners();
  }
}
