import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/travel/screen/sign_up.dart';

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
                    if (value.trim().length <= 0) {
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
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  cursorColor: Colors.white,
                  focusNode: passFocusNote,
                  onSaved: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value.trim().length < 6) {
                      return 'Password must greater than 6 character';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())),
                  child: Text(
                    'Sign up now',
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
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
