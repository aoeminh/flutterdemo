import 'dart:io';

//import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';

class Utils {
  static String formatDate(DateTime time, DateFormat format) {
    return format.format(time);
  }
//
//  static Future<File> pickImageFromGallery() {
//    print('ssss');
//    return ImagePicker.pickImage(source: ImageSource.gallery);
//  }
//
//  static Future<File> pickImageFromCamera() {
//    print('ssssss');
//    return ImagePicker.pickImage(source: ImageSource.camera);
//  }
}
