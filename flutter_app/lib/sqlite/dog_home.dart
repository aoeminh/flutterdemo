import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/common_widget/common_text_form_field.dart';
import 'package:flutter_app/sqlite/database_query.dart';
import 'package:flutter_app/sqlite/list_dog.dart';

import 'dog.dart';

enum DogHomeType { ADD, EDIT }

class DogHome extends StatefulWidget {
  @override
  _DogHomeState createState() => _DogHomeState();

  DogHome({this.dog, this.dogHomeType});

  final Dog dog;
  final DogHomeType dogHomeType;
}

class _DogHomeState extends State<DogHome> {
  String _name;
  int _age;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print('${widget.dogHomeType}');
    widget.dog != null
        ? _nameController.text = widget.dog.name
        : _nameController.text = '';
    widget.dog != null
        ? _ageController.text = widget.dog.age.toString()
        : _ageController.text = '';
    _name = '';
    _age = 0;
  }

  @override
  void dispose() {
    super.dispose();
    DbQuery dbQuery = DbQuery();
    dbQuery.closeDb();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            leading: widget.dogHomeType == DogHomeType.EDIT
                ? InkWell(
                    child: Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                : null,
            title: Text(widget.dogHomeType == DogHomeType.EDIT
                ? 'Edit Dog'
                : 'Dog Home')),
        body: buildBody(),
      ),
    );
  }

  buildBody() => Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                // name
                CommonTextFormField(
                  inputController: _nameController,
                  hintText: 'Dog name',
                  prefixIcon: Icon(Icons.person),
                  onChange: (value) {
                    _name = value;
                  },
                  validator: (value) {
                    if (value.length < 6) {
                      return 'Name must has 6 character';
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  height: 20,
                ),
                //age
                CommonTextFormField(
                  inputController: _ageController,
                  hintText: 'Age',
                  inputType: TextInputType.number,
                  prefixIcon: Icon(Icons.date_range),
                  onChange: (value) {
                    _age = int.parse(value);
                  },
                  validator: (value) {
                    final age = int.parse(value);
                    if (age < 1 || age > 18) {
                      return ' Age invalid';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                //submit
                _buildSubmitButton()
              ],
            ),
          ),
        ),
      );

  _buildSubmitButton() => InkWell(
        onTap: widget.dogHomeType == DogHomeType.EDIT ? _editDog : _addDog,
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.amberAccent),
          child: Center(
              child: Text(
                  widget.dogHomeType == DogHomeType.EDIT ? 'Save' : 'Submit')),
        ),
      );

  _addDog() async {
    if (key.currentState.validate()) {
      key.currentState.save();
      DbQuery dbQuery = DbQuery();
      await dbQuery.insertDog(_name, _age);
      Navigator.push(key.currentContext,
          MaterialPageRoute(builder: (BuildContext context) => ListDog()));
    }
  }

  _editDog() async {
    DbQuery dbQuery = DbQuery();
    int result =
        await dbQuery.updateDog(Dog(id: widget.dog.id, name: _name, age: _age));
  }

  String _data = "";
  int count = 0;

  Future<void> click() async {
    _data = 'Started $count at ${DateTime.now()}\n';
    print(_data);
    await Future.delayed(Duration(seconds: 2));
    var _data1 = 'Started $count at ${DateTime.now()}\n';
    count += 1;
    print(_data1);
  }
}
