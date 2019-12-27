import 'package:flutter/material.dart';
import 'package:flutter_app/local_event_app/model/category.dart';
import 'package:flutter_app/local_event_app/model/event.dart';

class Data{

 static List<Category> categoryList = [
    Category(icon: Icons.search,title: 'All',categoryType: CategoryType.ALL),
    Category(icon: Icons.music_note,title: 'Music',categoryType: CategoryType.MUSIC),
    Category(icon: Icons.location_on,title: 'Meetup',categoryType: CategoryType.MEET_UP),
    Category(icon: Icons.golf_course,title: 'Golf',categoryType: CategoryType.GOLF),
    Category(icon: Icons.cake,title: 'Birthday',categoryType: CategoryType.BIRTHDAY),
  ];

}