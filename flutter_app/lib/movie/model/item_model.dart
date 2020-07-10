import 'result.dart';

class ItemModel{

  int page;
  int totalResults;
  int totalPages;
  List<Result> results = [];


  ItemModel({this.page, this.totalResults, this.totalPages, this.results});

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(

  );
}