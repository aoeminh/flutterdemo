import 'package:flutter/material.dart';
import 'package:flutter_app/sqlite/database_query.dart';

import 'dog.dart';

class ListDog extends StatefulWidget {
  @override
  _ListDogState createState() => _ListDogState();
}

class _ListDogState extends State<ListDog> {
  List<Dog> listDog = List<Dog>();
  DbQuery dbQuery;

  @override
  void initState() async {
    super.initState();
    dbQuery = DbQuery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Dog'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() => FutureBuilder<List<Dog>>(
    future: dbQuery.getAllDog(),
    builder :(BuildContext context , AsyncSnapshot<List<Dog>> snapShot){
      if(snapShot.hasData){
        return ListView.builder(
            itemCount: listDog.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildRowItem(index, listDog[index].name, listDog[index].age);
            });
      }else{
        return Center(child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.amberAccent),));
      }
  }

  );

  _buildRowItem(int index, String name, int age) {
    Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text('$index'),
          ),
          Expanded(
              flex: 3,
              child: Column(children: <Widget>[Text('$name'), Text('$age')])),
          InkWell(
            onTap: () {},
            child: Expanded(
              flex: 1,
              child: Icon(Icons.edit),
            ),
          )
        ],
      ),
    );
  }
}
