import 'package:flutter/material.dart';
import 'package:flutter_app/form/widget/user_widget.dart';

class ListUserPage extends StatefulWidget {
  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 3,
    children: List.generate(10, (index){
      return UserItem();
    }),);
  }
}
