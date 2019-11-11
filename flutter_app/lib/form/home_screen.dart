import 'package:flutter/material.dart';

import 'form.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
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
  _HomeState({this.username, this.password});

  String username;
  final password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Hello $username '),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: _login,
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amberAccent),
                child: Center(
                  child: Text('Login'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormDemo())).then((result) {
          username = result;
          setState(() {
          });
    });
  }
}
