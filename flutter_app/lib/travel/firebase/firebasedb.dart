import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/travel/model/item_travel.dart';
import 'package:flutter_app/travel/model/travel.dart';

const String key_users = 'users';
const String key_email = 'email';
const String key_pass = 'password';
const String key_travels = 'travels';
const String key_travel_id = 'id';
const String key_travel_title = 'title';
const String key_travel_start_date = 'start_date';
const String key_travel_end_date = 'end_date';
const String key_travel_description = 'description';
const String key_places = 'places';
const String key_place_id = 'place_id';
const String key_place_title = 'place_title';
const String key_place_time = 'place_time';
const String key_place_image = 'place_image';
const String key_place_location = 'place_location';
const String key_place_lat = 'place_lat';
const String key_place_lng = 'place_lng';

class FirebaseDB {
  FirebaseDB._internal();

  static final FirebaseDB _instance = FirebaseDB._internal();

  static FirebaseDB get instance => _instance;

  static FirebaseDatabase get firebaseDatabase => FirebaseDatabase.instance;

  DatabaseReference getReference() => firebaseDatabase.reference();

  Future addUserIntoFirebase(FirebaseUser user, String pass) async {
    return await getReference()
        .child(key_users)
        .child(user.uid)
        .set({key_email: user.email, key_pass: pass});
  }

  Future addTrip(Travel travel,String uid) async {
    return await getReference().child(key_users).child(uid).child(key_travels).child(travel.id).set({
      key_travel_id: travel.id,
      key_travel_title: travel.title,
      key_travel_start_date: travel.startDate,
      key_travel_end_date: travel.endDate,
      key_travel_description: travel.description,
    });
  }

  Future addPlace(Place place,String uid,String travelId) async {
    return await getReference().child(key_users).child(uid).child(key_travels).child(travelId).child(place.id).set({
      key_travel_id: place.id,
      key_place_title: place.title,
      key_place_time: place.time,
      key_place_image: place.image,
      key_place_location: place.location,
      key_place_lat: place.lat,
      key_place_lng: place.lng,
    });
  }

  Future<DataSnapshot> getListTravel(String uid) async{
    final dbRef = await FirebaseDatabase.instance.reference().child(key_users).child(uid).child(key_travels).once();

    return dbRef;

  }
}
