import 'package:flutter/cupertino.dart';
import 'package:flutter_app/travel/model/item_travel.dart';

class Travel extends ChangeNotifier{

  String title;
  int startDate;
  int endDate;
  String description;
  Map<DateTime,List<ItemTravel>> item;

  Travel({this.title, this.startDate, this.endDate, this.description});

  void addItemTravel(DateTime key,ItemTravel itemTravel){
    if(item ==null) {
      item = Map<DateTime,List<ItemTravel>>();
    }
    if(item.containsKey(key)){
      item[key].add(itemTravel);
    }else{
      item[key] = List<ItemTravel>();
      item[key].add(itemTravel);
    }
    notifyListeners();
  }

}