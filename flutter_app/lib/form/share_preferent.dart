import 'package:shared_preferences/shared_preferences.dart';

const TOKEN = 'token';
class UserPrefs{

  static saveToken(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, token);
  }

  static getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(TOKEN);
  }

}