import 'package:intl/intl.dart';

class Util{

  static String convertTimeToString(int dateTime){
    return DateFormat('h:mm').format(DateTime.now());
  }
}