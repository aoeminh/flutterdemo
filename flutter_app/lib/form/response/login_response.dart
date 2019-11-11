class LoginResponse {
  LoginResponse(
      {this.bir,
      this.email,
      this.region,
      this.job,
      this.gender,
      this.token,
      this.userName});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        bir: json['bir'],
        email: json['email'],
        region: json['region'],
        job: json['job'],
        gender: json['gender'],
        token: json['token'],
        userName: json['user_name']);
  }

  String bir;
  int region;
  int job;
  int gender;
  String userName;
  String email;
  String token;
}