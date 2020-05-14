import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/travel/model/user.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameFocusNote = FocusNode();
  final passFocusNote = FocusNode();
  final rePassFocusNote = FocusNode();
  String username;
  String password;
  String rePassword;
  final key = GlobalKey<FormState>();
  final firebaseDB = FirebaseDatabase.instance;
  DatabaseReference reference;

  @override
  void initState() {
    super.initState();
    reference = firebaseDB.reference();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: _buildBody(),
    );
  }

  _buildBody() =>
      SingleChildScrollView(

        child: Container(
            margin: EdgeInsets.only(top: 200),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white)),
                      hintText: 'User name',
                    ),
                    textInputAction: TextInputAction.next,
                    focusNode: usernameFocusNote,

                    style: TextStyle(
                        color: Colors.white
                    ),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (v) =>
                        FocusScope.of(context).requestFocus(passFocusNote),
                    onSaved: (value) {
                      username = value;
                    },
                    validator: (value) {
                      if (value
                          .trim()
                          .length <= 0) {
                        return 'Username is empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white)),
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        color: Colors.white
                    ),
                    cursorColor: Colors.white,
                    focusNode: passFocusNote,
                    onSaved: (value) {
                      password = value;
                    },
                    onFieldSubmitted: (v) =>
                        FocusScope.of(context).requestFocus(rePassFocusNote),
                    validator: (value) {
                      if (value
                          .trim()
                          .length < 6) {
                        return 'Password must greater than 6 character';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white)),
                      hintText: 'Password again',

                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        color: Colors.white
                    ),
                    cursorColor: Colors.white,
                    focusNode: rePassFocusNote,
                    onSaved: (value) {
                      rePassword = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(

                    onTap: () {
                      key.currentState.save();
                      print(username);
                      reference.child('users').child(username).set({
                        'username': username,
                        'pass': password
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                  )
                ],
              ),
            )
        ),
      );
}
