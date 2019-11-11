class User {

  User(
      {this. region,
        this.isOnline,
        this.videoCallWaiting,
        this.isFav,
        this.voiceCallWaiting,
        this.callWaiting,
        this.long,
        this.lastLogin,
        this.userName,
        this.abt,
        this.age,
        this.avaId,
        this.gender,
        this.userId,
        this.lat,
        this.dist,
        this.thumbnailUrl});



  factory User.fromJson(Map<String, dynamic> json) => User(
      region : json['region'],
      isOnline: json['is_online'],
      videoCallWaiting: json['video_call_waiting'],
      isFav: json['is_fav'],
      voiceCallWaiting: json['voice_call_waiting'],
      callWaiting: json['call_waiting'],
      long: json['long'],
      lastLogin: json['last_login'],
      userName: json['user_name'],
      abt: json['abt'],
      age: json['age'],
      avaId: json['ava_id'],
      gender: json['gender'],
      userId: json['user_id'],
      lat: json['lat'],
      dist: json['dist'],
      thumbnailUrl: json['thumbnail_url']
  );

  int region;
  bool isOnline;
  bool videoCallWaiting;
  int isFav;
  bool voiceCallWaiting;
  int callWaiting;
  double long;
  String lastLogin;
  String userName;
  String abt;
  int age;
  String avaId;
  int gender;
  String userId;
  double lat;
  double dist;
  String thumbnailUrl;

}
