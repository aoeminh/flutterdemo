import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/travel/model/item_travel.dart';
import 'package:flutter_app/travel/utils.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  Completer<GoogleMapController> _controller = Completer();

  String title;
  DateTime startDate;
  String locationUrl;
  TimeOfDay time;
  DateTime selectedDate;
  File image;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    locationUrl = '';
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
              _buildMap(),
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

  _buildMap() => Container(
          child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Image.network(
              locationUrl,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _choseLocation();
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add_location,
                      color: Colors.blue,
                    ),
                    Text('Current Location'),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.map,
                    color: Colors.blue,
                  ),
                  Text('Open Map'),
                ],
              ),
            ],
          )
        ],
      ));

  _choseLocation() async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

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
                  model.addItemTravel(
                      startDate,
                      ItemTravel(
                          title: titleController.text,
                          image: image,
                          time: startDate
                              .add(Duration(
                                  hours: time.hour, minutes: time.minute))
                              .millisecondsSinceEpoch));
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
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
