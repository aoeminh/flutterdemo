class FirebaseDB {
  FirebaseDB._internal();

  static final FirebaseDB _instance = FirebaseDB._internal();

  static FirebaseDB get instance => _instance;
}
