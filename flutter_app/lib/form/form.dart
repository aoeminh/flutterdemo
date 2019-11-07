import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/form/home_screen.dart';
import 'package:dio/dio.dart';

final String _endpoint = "http://10.64.100.22:9119";

class FormDemo extends StatefulWidget {
  @override
  _FormDemoState createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> {
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

    passFoCus.addListener(() {
      if (passFoCus.hasFocus) {
        isPassFocus = true;
      } else {
        isPassFocus = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                          color:
                              isPassFocus ? Colors.amberAccent : Colors.grey),
                      borderRadius: BorderRadius.circular(50)),
                  child: TextFormField(
                    obscureText: true,
                    focusNode: passFoCus,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        hintText: 'pass'),
                    onSaved: (value){
                      _pass = value;
                    },
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const SizedBox(height: 20),
                RaisedButton(
                  color: Colors.amberAccent,
                  child: Text('Login'),
                  onPressed: _login,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login() {
      key.currentState.save();
      if(_usename != 'admin'){
        print('Invalid username');
        return;
      }

      if(_pass !=  '123456'){
        print('Invalid password');
        return;
      }


      print('Login success');

      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(username: _usename, password: _pass,)));
   }

   _requestLogin() async{
    Dio dio = Dio();
    Response response = await dio.post($)
   }
}
