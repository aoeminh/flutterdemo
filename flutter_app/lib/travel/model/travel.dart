import 'package:flutter/material.dart';

import 'item_travel.dart';

class Travel extends ChangeNotifier {
  String id;
  String title;
  int startDate;
  int endDate;
  String description;
  Map<DateTime, List<Place>> item;

  Travel({this.id, this.title, this.startDate, this.endDate, this.description});

  factory Travel.fromJson(Map<dynamic, dynamic> json) {
    return Travel(
      id: json['id'],
      title: json['title'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      description: json['description'],
    );
  }

  void addItemTravel(DateTime key, Place itemTravel) {
    if (item == null) {
      item = Map<DateTime, List<Place>>();
    }
    if (item.containsKey(key)) {
      item[key].add(itemTravel);
    } else {
      item[key] = List<Place>();
      item[key].add(itemTravel);
    }
    notifyListeners();
  }
}
