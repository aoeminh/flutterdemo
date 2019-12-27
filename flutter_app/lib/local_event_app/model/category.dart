import 'package:flutter/material.dart';
enum CategoryType{
  ALL,
  MUSIC,
  MEET_UP,
  GOLF,
  BIRTHDAY
}

class Category{

  IconData icon;
  String title;
  CategoryType categoryType;

  Category({this.icon, this.title,this.categoryType});
}