import 'package:flutter/material.dart';

import 'item_travel.dart';

class Travel extends ChangeNotifier {
  String id;
  String title;
  int startDate;
  int endDate;
  String description;
  String primaryColor;
  String accentColor;
  Map<DateTime, List<Place>> item;

  Travel({this.id, this.title, this.startDate, this.endDate, this.description,this.primaryColor, this.accentColor});

  factory Travel.fromJson(Map<dynamic, dynamic> json) {
    return Travel(
      id: json['id'],
      title: json['title'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      description: json['description'],
      primaryColor: json['primaryColor'],
      accentColor: json['accentColor'],
    );
  }

  void addPlace(DateTime key, Place place) {
    if (item == null) {
      item = Map<DateTime, List<Place>>();
    }
    addNewPlace(key,place);
  }

  void editPlace({DateTime newKey, DateTime oldKey,Place place,int index}){
    print('$newKey $oldKey');
    if(newKey == oldKey){
      print('${place.title}');
      item[newKey][index] = place;
      notifyListeners();
    }else{
      item[oldKey].removeAt(index);
      addNewPlace(newKey,place);
    }
  }

  void addNewPlace(DateTime key,Place place){
    if (item.containsKey(key)) {
      item[key].add(place);
    } else {
      item[key] = List<Place>();
      item[key].add(place);
    }
    notifyListeners();
  }

  void clearListPlaces(){
    if(item !=null){
      item.clear();
      notifyListeners();
    }
  }
}
