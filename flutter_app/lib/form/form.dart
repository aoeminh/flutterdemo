import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/form/list_user_page.dart';
import 'package:flutter_app/form/request/login_request.dart';
import 'package:flutter_app/form/response/login_response.dart';
import 'package:flutter_app/form/share_preferent.dart';
import 'package:flutter_app/form/widget/input_form.dart';

final String _endpoint = "http://10.64.100.22:9119";

class FormDemo extends StatefulWidget {
  @override
  _FormDemoState createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final key = GlobalKey<FormState>();

  String _usename;
  String _pass;
  final passFoCus = FocusNode();
  final userFoCus = FocusNode();

  bool isUserFocus = false;
  bool isPassFocus = false;

  @override
  void initState() {
    super.initState();
    print('init');
    userFoCus.addListener(() {
      print('focus');
      if (userFoCus.hasFocus) {
        isUserFocus = true;
        print('focus');
      } else {
        isUserFocus = false;
        print('focus');
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Demo'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: key,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              InputForm(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: isUserFocus ? Colors.amberAccent : Colors.grey),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextFormField(
                  focusNode: userFoCus,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      hintText: 'username'),
                  validator: (value) {
                    if (value.length < 6) {
                      return 'value not < 6';
                    } else if (value != 'admin') {
                      return ('Invalid username');
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _usename = value;
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (v) =>
                      {FocusScope.of(context).requestFocus(passFoCus)},
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: isPassFocus ? Colors.amberAccent : Colors.grey),
                    borderRadius: BorderRadius.circular(50)),
                child: TextFormField(
                  obscureText: true,
                  focusNode: passFoCus,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      hintText: 'pass'),
                  onSaved: (value) {
                    _pass = value;
                  },
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(height: 20),
              RaisedButton(
                color: Colors.amberAccent,
                child: Text('Login'),
                onPressed: _login1,
              )
            ],
          ),
        ),
      ),
    );
  }

  _login1() async {
    key.currentState.save();

    LoginRequest loginRequest = LoginRequest(username: _usename, pass: _pass);
    Dio dio = Dio();
    Response response = await dio.post(_endpoint,data:  loginRequest.toJson());
    Map<String ,dynamic> map = jsonDecode(response.toString());
    LoginResponse loginResponse = LoginResponse.fromJson(map['data']);
    if(map['code'] == 0){
      print(loginResponse.userName);
      UserPrefs.saveToken(loginResponse.token);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => ListUserPage()));
    }
  }

}
