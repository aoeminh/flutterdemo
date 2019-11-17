import 'package:flutter/material.dart';
import 'package:flutter_app/common_widget/common_text_form_field.dart';
import 'package:flutter_app/sqlite/database_query.dart';
import 'package:flutter_app/sqlite/list_dog.dart';

class DogHome extends StatefulWidget {
  @override
  _DogHomeState createState() => _DogHomeState();
}

class _DogHomeState extends State<DogHome> {
  String _name;
  int _age;
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _name = '';
    _age = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Dog Home')),
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
                _buildSubmitButon()
              ],
            ),
          ),
        ),
      );

  _buildSubmitButon() => InkWell(
        onTap: _submit,
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.amberAccent),
          child: Center(child: Text('Submit')),
        ),
      );

  _submit() async {
    if (key.currentState.validate()) {
      key.currentState.save();
      DbQuery dbQuery = DbQuery();
      await dbQuery.insertDog(_name, _age);
      Navigator.push(key.currentContext, MaterialPageRoute(builder: (BuildContext context) => ListDog()));
    }
  }
}
