import 'package:flutter/services.dart';

class AppSetting {
  // Static constant variable to initialize MethodChannel of 'app_settings'.
  static const MethodChannel _channel = const MethodChannel('app_settings');

  // Future async method call to open WIFI settings.
  static Future<void> openWIFISettings() async {
    _channel.invokeMethod('wifi',['s1','s1','s2']);
  }

  /// Future async method call to open location settings.
  static Future<void> openLocationSettings() async {
    _channel.invokeMethod('location');
  }

  /// Future async method call to open security settings.
  static Future<void> openSecuritySettings() async {
    _channel.invokeMethod('security');
  }

  /// Future async method call to open app specific settings screen.
  static Future<void> openAppSettings() async {
    _channel.invokeMethod('app_settings');
  }
}
