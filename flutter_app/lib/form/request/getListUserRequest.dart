class GetListUserRequest {
  GetListUserRequest({this.token});

  Map<String, dynamic> toJson() => <String, dynamic>{
        "distance": 4,
        "filter": 0,
        "is_new_login": false,
        "lat": 21.0465572,
        "long": 105.7984511,
        "lower_age": 18,
        "region": [],
        "skip": 0,
        "sort_type": 1,
        "take": 48,
        "upper_age": 120,
        "api": "meet_people",
        "token": token
      };

  String token;
}
