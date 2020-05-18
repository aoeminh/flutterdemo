import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

const String key_users = 'users';
const String key_email = 'email';
const String key_pass = 'password';

class FirebaseDB {
  FirebaseDB._internal();

  static final FirebaseDB _instance = FirebaseDB._internal();

  static FirebaseDB get instance => _instance;

  static FirebaseDatabase get firebaseDatabase => FirebaseDatabase.instance;


  DatabaseReference getReference() => firebaseDatabase.reference();

  Future addUserIntoFirebase(FirebaseUser user,String pass) async {
    print(firebaseDatabase);
    return await  getReference()
        .child(key_users).child(user.uid)
        .set({key_email: user.email, key_pass: pass});
  }
}
