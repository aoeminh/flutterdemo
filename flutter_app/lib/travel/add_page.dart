import 'package:flutter/material.dart';
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
  DateTime selectedDate = DateTime.now();
  String title;
  int startDate;
  int endDate;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },child: Icon(Icons.arrow_back)),
        title: Text('Add trip'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                        print('$startDate');
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
                    onPressed: () {
                      if (!_validate(context)) {
                        return;
                      }
                      Travel travel = Travel(
                          title: titleController.text,
                          startDate: startDate,
                          endDate: endDate,
                          description: descriptionController.text);
                      if (widget.isEdit) {
                        model.editTravel(
                            model.travels.indexOf(widget.travel), travel);
                      } else {
                        model.setTravel(travel);
                      }

                      Navigator.pop(context);
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
    if (picked != null && picked != selectedDate)
      setState(() {
        valueChanged(picked);
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
