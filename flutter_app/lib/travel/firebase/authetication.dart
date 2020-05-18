import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  FirebaseAuth _auth;

  Authentication._internal();

  static final Authentication _instance = Authentication._internal();

  static Authentication get instance => _instance;

  FirebaseAuth firebaseAuth() {
    if (_auth == null) {
      return _auth = FirebaseAuth.instance;
    } else {
      return _auth;
    }
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    FirebaseUser user = (await firebaseAuth().createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  Future<FirebaseUser> signIn(String email, String password) async {
    FirebaseUser user = (await firebaseAuth().signInWithEmailAndPassword(
        email: email, password: password))
        .user;
    return user;
  }

}
