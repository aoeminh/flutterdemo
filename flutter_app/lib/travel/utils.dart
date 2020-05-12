import 'dart:convert';
import 'dart:io';

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
    return extractedData['results'][0]['formatted_address'];
  }
}
