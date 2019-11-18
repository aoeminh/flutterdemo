import 'package:flutter/material.dart';
import 'package:flutter_app/sqlite/database_query.dart';
import 'package:flutter_app/sqlite/dog_home.dart';

import 'dog.dart';

class ListDog extends StatefulWidget {
  @override
  _ListDogState createState() => _ListDogState();
}

class _ListDogState extends State<ListDog> {
  List<Dog> listDog = List<Dog>();
  DbQuery dbQuery;

  @override
  void initState() {
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

  _buildBody() =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder<List<Dog>>(
            future: dbQuery.getAllDog(),
            builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapShot) {
              if (snapShot.hasData) {
                listDog.clear();
                listDog.addAll(snapShot.data);
                print('${listDog.length}');
                return ListView.builder(
                    itemCount: listDog.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildRowItem(
                          index, listDog[index].name, listDog[index].age);
                    });
              } else {
                return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.amberAccent),
                    ));
              }
            }),
      );

  Widget _buildRowItem(int index, String name, int age) {
    return Column(
      children: <Widget>[
        SizedBox(height: 5),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('${index + 1}'))),
              Expanded(
                  flex: 6,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[Text('$name'), Text('$age')]))),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _editDog(name,age);
                  },
                  child: Icon(Icons.edit),
                ),
              )
            ]),
        SizedBox(height: 5),
        Divider(height: 1, color: Colors.grey)
      ],
    );
  }

  _editDog(String name, int age) {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => DogHome(name: name, age: age,dogHomeType: DogHomeType.EDIT,)));
  }
}
