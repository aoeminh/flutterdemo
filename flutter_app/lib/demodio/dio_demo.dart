import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:access_settings_menu/access_settings_menu.dart';
class DemoDIO extends StatefulWidget {
  @override
  _DemoDIOState createState() => _DemoDIOState();
}

class _DemoDIOState extends State<DemoDIO> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('DIO Demo'),
        ),
        body: Container(
          child: CustomButton(
            onClickButton: openSettingsMenu,
          ),
        ),
      ),
    );
  }

  void getHttp() async {
    try {
      Response response;
      Dio dio = new Dio();
//      response = await dio.get("/test?id=12&name=wendu");
      print(response.data.toString());
// Optionally the request above could also be done as
//      response = await dio.get("/test", queryParameters: {"id": 12, "name": "wendu"});
      dio.get<String>("https://www.thelotent.com/WSVistaWebClient/OData.svc/GetNowShowingSessions?\$format=json&\$filter=CinemaId+eq+%27100%27").then((r) {
        setState(() {
          print(r.data);
//          _text = r.data.replaceAll(RegExp(r"\s"), "");
        });
      }).catchError(print);
    } catch (e) {
      print(e);
    }
  }
}

openSettingsMenu() async {
  var resultSettingsOpening = false;

  try {
    resultSettingsOpening =
    await AccessSettingsMenu.openSettings(settingsType: 'ACTION_WIFI_SETTINGS');
  } catch (e) {
    resultSettingsOpening = false;
  }
}


typedef OnClickButton = void Function();
class CustomButton extends StatefulWidget {

  const CustomButton({Key key, this.onClickButton}) : super(key: key);

  final OnClickButton onClickButton;

  @override
  _StateCustomButton createState() => _StateCustomButton(onClickButton);
}

class _StateCustomButton extends State<CustomButton> {

  _StateCustomButton(this.onClickButton);

  final OnClickButton onClickButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClickButton,
      child: Container(
        width: 100,
        height: 50,
        child: Text('CustomButton'),
      ),
    );
  }
}

