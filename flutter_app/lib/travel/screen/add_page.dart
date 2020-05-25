import 'package:flutter/material.dart';
import 'package:flutter_app/travel/firebase/authetication.dart';
import 'package:flutter_app/travel/firebase/firebasedb.dart';
import 'package:flutter_app/travel/model/my_model.dart';
import 'package:flutter_app/travel/model/travel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  final Travel travel;
  final isEdit;

  AddPage({this.travel, this.isEdit});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  DateTime selectedDate = DateTime.now()
      .add(Duration(hours: 0, seconds: 0, milliseconds: 0, minutes: 0));
  String title;
  int startDate;
  int endDate;
  String uidFirebase;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.travel != null) {
      titleController.text = widget.travel.title;
      startDateController.text = _formatDate(
          DateTime.fromMillisecondsSinceEpoch(widget.travel.startDate),
          DateFormat('dd/MM/yyyy'));

      endDateController.text = _formatDate(
          DateTime.fromMillisecondsSinceEpoch(widget.travel.endDate),
          DateFormat('dd/MM/yyyy'));
      descriptionController.text = widget.travel.description;
      endDate = widget.travel.endDate;
      startDate = widget.travel.startDate;
    } else {
      descriptionController.text = '';
    }
    Authentication.instance.firebaseAuth().currentUser().then((value) {
      uidFirebase = value.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text('Add trip'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: 'Title*',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
                onSaved: (value) {
                  title = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate((DateTime datetime) {
                        startDate = datetime.millisecondsSinceEpoch;
                        startDateController.text =
                            _formatDate(datetime, DateFormat('dd/MM/yyyy'));
                      }, context),
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'Start date*',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                        controller: startDateController,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('-')),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate((datetime) {
                        endDate = datetime.millisecondsSinceEpoch;
                        print('$endDate');
                        endDateController.text =
                            _formatDate(datetime, DateFormat('dd/MM/yyyy'));
                      }, context),
                      child: TextFormField(
                        enabled: false,
                        controller: endDateController,
                        decoration: InputDecoration(
                            labelText: 'End date*',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: 'Descrition',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<MyModel>(
                builder: (context, model, child) => Center(
                  child: FlatButton(
                    color: Colors.blue,
                    onPressed: !widget.isEdit
                        ? () {
                      print('add');
//                            addTravel(model);
                          }
                        : () {
                      print('edit');
                            editTravel(model);
                          },
                    child: Text(
                      widget.isEdit ? 'EDIT' : 'ADD',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addTravel(MyModel model) {
    if (!_validate(context)) {
      return;
    }

    addToFirebase(model);
  }

  editTravel(MyModel model) {
    print('editTravel');
    widget.travel.title = titleController.text;
    widget.travel.startDate = startDate;
    widget.travel.endDate = endDate;
    widget.travel.description = descriptionController.text;

    FirebaseDB.instance.addTrip(widget.travel, uidFirebase).then((value) {
      model.editTravel(model.travels.indexOf(widget.travel), widget.travel);
      Navigator.pop(context);
    });
  }

  addToFirebase(MyModel model) {
    Travel travel = Travel(
        title: titleController.text,
        startDate: startDate,
        endDate: endDate,
        description: descriptionController.text);

    String travelId = FirebaseDB.instance.getReference().push().key;
    travel.id = travelId;
    FirebaseDB.instance.addTrip(travel, uidFirebase).then((value) {
      model.setTravel(travel);
      Navigator.pop(context);
    }).catchError((onError) {});
  }

  String _formatDate(DateTime time, DateFormat format) {
    return format.format(time);
  }

  Future<Null> _selectDate(
      ValueChanged<DateTime> valueChanged, BuildContext context) async {
    hideKeyBoard(context);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    print('$picked');
    if (picked != null)
      setState(() {
        DateTime date = new DateTime(
          picked.year,
          picked.month,
          picked.day,
        );
        valueChanged(date);
      });
  }

  static hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  bool _validate([BuildContext context]) {
    if (titleController.text.trim().isEmpty) {
      _showAlert(context, 'Title is required');
      return false;
    }

    if (startDate == null || endDate == null) {
      _showAlert(context, 'Choose date');
      return false;
    }

    if (endDate.compareTo(startDate) < 0) {
      _showAlert(context, 'End date not be smaller start date');
      return false;
    }
    return true;
  }

  _showAlert(BuildContext context, String content) {
    print(content);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(content),
    ));
  }
}
