import 'package:flutter/material.dart';
import 'package:flutter_app/common_widget/common_text_form_field.dart';
import 'package:flutter_app/sqlite/database_query.dart';
import 'package:flutter_app/sqlite/list_dog.dart';

enum DogHomeType { ADD, EDIT }

class DogHome extends StatefulWidget {
  @override
  _DogHomeState createState() => _DogHomeState();

  DogHome({this.name, this.age, this.dogHomeType});

  final name;
  final age;
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
    widget.name != null
        ? _nameController.text = widget.name
        : _nameController.text = '';
    widget.age != null
        ? _ageController.text = widget.age.toString()
        : _nameController.text = '';
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
                _buildSubmitButon()
              ],
            ),
          ),
        ),
      );

  _buildSubmitButon() => InkWell(
        onTap: _addDog,
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

  _editDog() async{
    DbQuery dbQuery = DbQuery();
    await dbQuery.getDogById(id)
  }
}
