import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/travel/screen/sign_up.dart';
import 'package:flutter_app/travel/widget/text_form_field_widget.dart';

import '../utils.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final key = GlobalKey<FormState>();
  final usernameFocusNote = FocusNode();
  final passFocusNote = FocusNode();
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: _buildBody(),
    );
  }

  _buildBody() => SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormFieldWidget(
                  hintText: 'Email',
                  focusNode: usernameFocusNote,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (v) =>
                      FocusScope.of(context).requestFocus(passFocusNote),
                  onSave: (value) {
                    username = value;
                  },
                  onValidate: (value) {
                    if (value.trim().length < 0) {
                      return 'Email is empty';
                    } else if (!Utils.isEmail(value)) {
                      return 'Email invalid';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormFieldWidget(
                  hintText: 'Password',
                  focusNode: passFocusNote,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  onFieldSubmitted: (v) =>
                      FocusScope.of(context).requestFocus(passFocusNote),
                  onSave: (value) {
                    password = value;
                  },
                  onValidate: (value) {
                    if (value.trim().length < 6) {
                      return 'Password must greater than 6 character';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp())),
                  child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an Account? ',
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ]
                  ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  _signIn() {
    key.currentState.validate();
    key.currentState.save();
  }
}
