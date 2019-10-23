import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Login demo',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Login'),
        leading: Icon(Icons.menu),
        actions: <Widget>[
          Icon(Icons.edit),
          Icon(Icons.delete),
        ],
        bottom: PreferredSize(
          child: Icon(Icons.print),
        ),
      ),
    );
  }
}
