

class Place {
  String id;
  String title;
  int time;
  int startTime;
  String image;
  String location;
  double lat;
  double lng;

  Place(
      {this.id,this.title, this.time, this.image, this.location, this.lat, this.lng,this.startTime});

  factory Place.fromJson(Map<dynamic,dynamic> json)=> Place(
    id : json['place_id'],
    title : json['place_title'],
    time : json['place_time'],
    startTime: json['place_start_time'],
    image : json['place_image'],
    location : json['place_location'],
    lat : json['place_lat'],
    lng : json['place_lng']
  );
}
