import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/travel/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  String location;
  LatLng latLng;

  @override
  void initState()  {
    super.initState();
    _choseLocation().then((value) {
      setState(() {
        latLng = value;
        _selectedLocation(latLng);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
        title: Text('Choose Location'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () => Navigator.pop(context, latLng),
              child: Icon(Icons.check),
            ),
          )
        ],
      ),
      body: latLng !=null?GoogleMap(
        initialCameraPosition: CameraPosition(target: latLng, zoom: 15),
        onMapCreated: (controller) => {_controller.complete(controller)},
        onTap: _selectedLocation,
        markers: _markers,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapToolbarEnabled: true,
        compassEnabled: true,
      ): Container(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ),
    );
  }

  _selectedLocation(LatLng latLng) async {
    location = await Utils.getPlaceAddress(latLng.latitude, latLng.longitude);
    _markers.clear();
    _markers.add(Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        infoWindow: InfoWindow(title: location)));
    final GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15)));
    this.latLng = latLng;
    setState(() {});
  }

  Future<LatLng>_choseLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    _locationData = await location.getLocation();
    return LatLng(_locationData.latitude,_locationData.longitude);
  }
}
