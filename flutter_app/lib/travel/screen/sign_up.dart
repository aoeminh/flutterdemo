import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/travel/firebase/authetication.dart';
import 'package:flutter_app/travel/firebase/firebasedb.dart';
import 'package:flutter_app/travel/widget/text_form_field_widget.dart';

import '../utils.dart';

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

  bool isShowLoading;
  bool isClick;

  @override
  void initState() {
    super.initState();
    isShowLoading = false;
    isClick = true;
    reference = firebaseDB.reference();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: _buildBody(),
    );
  }

  _buildBody() => Center(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(top: 50),
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
                          onFieldSubmitted: (v) => FocusScope.of(context)
                              .requestFocus(passFocusNote),
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
                          onFieldSubmitted: (v) => FocusScope.of(context)
                              .requestFocus(passFocusNote),
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
                          height: 10,
                        ),
                        TextFormFieldWidget(
                          hintText: 'Confirm password',
                          focusNode: rePassFocusNote,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          onSave: (value) {
                            rePassword = value.trim();
                          },
                          onValidate: (value) {
                            if (value != password) {
                              return 'Confirm Password not equal Password';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Offstage(
                          offstage: !isShowLoading,
                          child: Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: isClick ? _signUp : () {},
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: RichText(
                            text:
                                TextSpan(text: 'Have an Account? ', children: [
                              TextSpan(
                                  text: 'Sign in',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ))
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      );

  _showLoading() {
    setState(() {
      isShowLoading = true;
    });
  }

  _hideLoading() {
    setState(() {
      isShowLoading = false;
    });
  }

  _signUp() async {
    Utils.hideKeyBoard(context);
    key.currentState.save();
    isClick = true;
    if (key.currentState.validate()) {
      _showLoading();
      Authentication.instance.signUp(username, password).then((user) {
        FirebaseDB.instance.addUserIntoFirebase(user, password).then((value) {
          Utils.showDialogNotify(
              context: context,
              content: 'Register successful',
              callback: () => Navigator.pop(context));
          _hideLoading();
          isClick = true;
        }).catchError((onError) {
          Utils.showDialogNotify(
            context: context,
            content: onError.toString(),
          );
          _hideLoading();
          isClick = true;
        });
      }).catchError((onError) {
        Utils.showDialogNotify(
          context: context,
          content: onError.toString(),
        );
        _hideLoading();
        isClick = true;
      });
    }
  }
}
