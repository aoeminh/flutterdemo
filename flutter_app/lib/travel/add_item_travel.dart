import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/travel/model/item_travel.dart';
import 'package:flutter_app/travel/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'model/travel.dart';

class AddItemTravel extends StatefulWidget {
  final Travel travel;

  AddItemTravel(this.travel);

  @override
  _AddItemTravelState createState() => _AddItemTravelState();
}

class _AddItemTravelState extends State<AddItemTravel> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String title;
  DateTime startDate;
  TimeOfDay time;
  DateTime selectedDate;
  File image;

  @override
  void initState() {
    super.initState();
    startDateController.text = Utils.formatDate(
        DateTime.fromMillisecondsSinceEpoch(widget.travel.startDate),
        DateFormat('dd/MM/yyy'));
    selectedDate = DateTime.fromMillisecondsSinceEpoch(widget.travel.startDate);

    startDate = DateTime.fromMillisecondsSinceEpoch(widget.travel.startDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
        title: Text('Add trip'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        startDate = datetime;
                        startDateController.text =
                            Utils.formatDate(datetime, DateFormat('dd/MMM'));
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
                      onTap: () {
                        chooseTime(context).then((onValue) {
                          setState(() {
                            time = onValue;
                            timeController.text = time.format(context);
                          });
                        });
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: timeController,
                        decoration: InputDecoration(
                            labelText: 'Time*',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              _buildChooseImage(),
              SizedBox(
                height: 20,
              ),
              _addButton(),
            ],
          ),
        ),
      );

  _buildChooseImage() => InkWell(
        onTap: _showBottomSheet,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 250,
          child: this.image == null
              ? Icon(
                  Icons.photo,
                  size: 50,
                  color: Colors.grey,
                )
              : Image.file(
                  image,
                  fit: BoxFit.cover,
                ),
        ),
      );

  Future<Null> _selectDate(
      ValueChanged<DateTime> valueChanged, BuildContext context) async {
    hideKeyBoard(context);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.fromMillisecondsSinceEpoch(widget.travel.startDate),
        lastDate: DateTime.fromMillisecondsSinceEpoch(widget.travel.endDate));
    if (picked != null && picked != selectedDate)
      setState(() {
        valueChanged(picked);
      });
  }

  static hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  _showBottomSheet() {
    hideKeyBoard(context);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (context) => Container(
              height: 150,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        Utils.pickImageFromCamera().then((image) {
                          setState(() {
                            Navigator.pop(context);
                            this.image = image;
                          });
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Take picture',
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  InkWell(
                      onTap: () {
                        Utils.pickImageFromGallery().then((image) {
                          setState(() {
                            Navigator.pop(context);
                            this.image = image;
                          });
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text('Choose  from gallery',
                            style: TextStyle(fontSize: 20)),
                      ))
                ],
              ),
            ));
  }

  Future<TimeOfDay> chooseTime(BuildContext context) {
    Future<TimeOfDay> selectedTimeRTL = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return selectedTimeRTL;
  }

  _addButton() => Container(
          child: Center(
        child: Consumer<Travel>(
          builder: (context, model, child) => InkWell(
            child: FlatButton(
              color: Colors.blue,
              onPressed: () {
                if (validate(context)) {
                  model.addItemTravel(ItemTravel(
                      title: titleController.text,
                      image: image,
                      time: startDate
                          .add(Duration(hours: time.hour, minutes: time.minute))
                          .millisecondsSinceEpoch));
                  Navigator.pop(context);
                }
              },
              child: Text('Add',style: TextStyle(color: Colors.white),),
            ),
          ),
        ),
      ));

  bool validate(BuildContext context) {
    if (titleController.text.trim().isEmpty) {
      _showAlert(context, 'Title is required');
      return false;
    }

    if (time == null) {
      _showAlert(context, 'Time is required');
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
