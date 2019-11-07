import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

class LoginRequest{

  LoginRequest({this.username,this.pass});

  Map<String, dynamic> toJson() => <String,dynamic> {
    'email': username,
    'phone_number' : '',
    'pwd' : generateMd5(pass),
    "application_version": "2.1.8",
    "device_id": "0df9e381a53ecdc8",
    "device_name": "Redmi Note 5",
    "device_type": 1,
    "gps_adid": "",
    "login_time": "",
    "notify_token": "",
    "os_version": "",
    "api": "login"
  };

  final String username;
  final String pass;

  ///Generate MD5 hash
  static generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}