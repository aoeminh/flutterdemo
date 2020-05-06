import 'package:flutter/cupertino.dart';
import 'package:flutter_app/travel/model/item_travel.dart';

class Travel extends ChangeNotifier{

  String title;
  int startDate;
  int endDate;
  String description;
  List<ItemTravel> itemTravels = [];

  Travel({this.title, this.startDate, this.endDate, this.description});

  void addItemTravel(ItemTravel itemTravel){
    print('ssss');

    itemTravels.add(itemTravel);
    notifyListeners();
  }

}