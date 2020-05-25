import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/travel/firebase/authetication.dart';
import 'package:flutter_app/travel/firebase/firebasedb.dart';
import 'file:///E:/MinhGVN/FlutterProject/flutter_app/lib/travel/screen/map.dart';
import 'package:flutter_app/travel/model/item_travel.dart';
import 'package:flutter_app/travel/model/travel.dart';
import 'package:flutter_app/travel/utils.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  String address;
  TimeOfDay time;
  DateTime selectedDate;
  File image;
  bool isShowLoading;
  LatLng latLng;
  String uidFirebase;

  @override
  void initState() {
    super.initState();
    isShowLoading = false;
    locationUrl = '';
    address = '';
    startDateController.text = Utils.formatDate(
        DateTime.fromMillisecondsSinceEpoch(widget.travel.startDate),
        DateFormat('dd/MM/yyy'));
    selectedDate = DateTime.fromMillisecondsSinceEpoch(widget.travel.startDate);

    startDate = DateTime.fromMillisecondsSinceEpoch(widget.travel.startDate);
    Authentication.instance.firebaseAuth().currentUser().then((value) {
      uidFirebase = value.uid;
    });
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

  Widget _buildMap() {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    locationUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Offstage(
                  offstage: !isShowLoading,
                  child: Container(
                    color: Colors.white.withOpacity(0.8),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  ),
                )
              ],
            )),
        SizedBox(
          height: 10,
        ),
        Text(address),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InkWell(
              onTap: () {
                _showLoading();
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
            InkWell(
              onTap: _navigateToChooseLocation,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.map,
                    color: Colors.blue,
                  ),
                  Text('Open Map'),
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }

  _choseLocation() async {
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
    _setMap(_locationData.latitude, _locationData.longitude);
    _hideLoading();
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
                  print('sssss');
                  addPlace(model);
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

  addPlace(Travel model) async {
    print('addPlace');
    String url;
    if (image != null) {
      StorageTaskSnapshot data = await uploadImage();
      print('upload finish');
      String url = (await data.ref.getDownloadURL()).toString();
    }else{
      url='';
    }

    String placeId = FirebaseDB.instance.getReference().push().key;
    Place place = Place(
        id: placeId,
        title: titleController.text,
        image: url,
        time: startDate
            .add(Duration(hours: time.hour, minutes: time.minute))
            .millisecondsSinceEpoch,
        lat: latLng.latitude,
        lng: latLng.longitude,
        location: address);
    FirebaseDB.instance.addPlace(place, uidFirebase, model.id).then((value) {
      model.addItemTravel(startDate, place);
      Navigator.pop(context);
    }).catchError((onError) {
      Utils.showDialogNotify(
          context: context, content: onError.toString(), callback: () {});
    });
  }

  Future<StorageTaskSnapshot> uploadImage() {
    print('start upload ${image.path.split('/').last}');
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child('image${path.basename(image.path.split('/').last)}');
    StorageUploadTask uploadTask = reference.putFile(image);
    return uploadTask.onComplete;
  }

  _showLoading() {
    setState(() {
      isShowLoading = true;
    });
  }

  _hideLoading() {
    setState(() {
      isShowLoading = false;
    });
  }

  _showAlert(BuildContext context, String content) {
    print(content);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(content),
    ));
  }

  _navigateToChooseLocation() async {
    LatLng latLng = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseLocation()),
    );
    if (latLng != null) {
      this.latLng = latLng;
    }
    _setMap(this.latLng.latitude, this.latLng.longitude);
  }

  _setMap(double lat, double long) async {
    latLng = LatLng(lat, long);
    address = await Utils.getPlaceAddress(lat, long);
    setState(() {
      locationUrl =
          Utils.generateLocationPreviewImage(latitude: lat, longitude: long);
    });
  }
}
