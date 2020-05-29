import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const GOOGLE_API_KEY = 'AIzaSyA_nGphIQ7x1zOv0X0gOdgy42fz3srEGRI';

class Utils {
  static String formatDate(DateTime time, DateFormat format) {
    return format.format(time);
  }

  static Future<File> pickImageFromGallery() {
    return ImagePicker.pickImage(source: ImageSource.gallery);
  }

  static Future<File> pickImageFromCamera() {
    return ImagePicker.pickImage(source: ImageSource.camera);
  }

  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    if(extractedData['status'] != 'INVALID_REQUEST'){
      return extractedData['results'][0]['formatted_address'];
    }else{
      return '';
    }
  }

  static showDialogNotify({BuildContext context, String content , Function callback}) {
    showDialog(
        context: context,
        child: AlertDialog(
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
              Navigator.pop(context);
              callback();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ));
  }

  static hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }
}
