import 'package:flutter/material.dart';

import 'form.dart';

class HomePage extends StatefulWidget {
  HomePage({this.username, this.password});

  final username;
  final password;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home page'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Hello ${widget.username} '),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amberAccent),
                child: Center(
                  child: InkWell(
                    onTap: _login,
                    child: Text('Login'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormDemo()));
  }
}
