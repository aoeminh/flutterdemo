import 'dart:convert';

import 'message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagePreferences {
  static saveListMessage(List<Message> messages) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('list', jsonEncode(messages));
  }

  static Future<List<Message>> getListMessage() async {
    final prefs = await SharedPreferences.getInstance();
    return List<Message>.from(
        (jsonDecode(prefs.getString('list'))).map((m) => Message.fromJson(m)));
  }

  static removeListMessage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('list');
  }
}
