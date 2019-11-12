import 'package:flutter/material.dart';

class SignUppage extends StatefulWidget {
  @override
  _SignUppageState createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: _buildBody(),
    );
  }

  _buildBody() => Container(
    child: Column(

    ),
  );
}
