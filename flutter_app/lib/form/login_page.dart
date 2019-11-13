import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/form/list_user_page.dart';
import 'package:flutter_app/form/request/login_request.dart';
import 'package:flutter_app/form/response/login_response.dart';
import 'package:flutter_app/form/share_preferent.dart';
import 'package:flutter_app/form/sign_up_page.dart';
import 'package:flutter_app/form/widget/input_form.dart';
import 'package:flutter_app/generated/i18n.dart';

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
  final passForCus = FocusNode();
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
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Form Demo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                InputForm(
                  hintText: 'username',
                  nextFocusNode: passForCus,
                  action: TextInputAction.next,
                  onSave: (value) {
                    _usename = value;
                  },
                ),
                const SizedBox(height: 20),
                //password
                InputForm(
                  hintText: 'password',
                  focusNode: passForCus,
                  action: TextInputAction.done,
                  obscureText: true,
                  onSave: (value) {
                    _pass = value;
                  },
                ),
                const SizedBox(height: 20),
                RaisedButton(
                  color: Colors.amberAccent,
                  child: Text('Login'),
                  onPressed: _login1,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SignUppage()));
                  },
                  child: RichText(
                    text: TextSpan(
                        text: 'Bạn chưa có tài khoản? ',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Đăng ký ngay',
                              style: TextStyle(color: Colors.amberAccent))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login1() async {
    key.currentState.save();
    print('$_usename $_pass');
    LoginRequest loginRequest = LoginRequest(username: _usename, pass: _pass);
    Dio dio = Dio();
    Response response = await dio.post(_endpoint, data: loginRequest.toJson());
    Map<String, dynamic> map = jsonDecode(response.toString());
    LoginResponse loginResponse = LoginResponse.fromJson(map['data']);
    if (map['code'] == 0) {
      print(loginResponse.userName);
      UserPrefs.saveToken(loginResponse.token);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => ListUserPage()));
    }
  }
}
