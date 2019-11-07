class LoginResponse{

  LoginResponse({
    this.bir,
    this.email,
    this.region,
    this.job,
    this.gender,
    this.token,
    this.user_name
  });

  final String bir;
  final int region;
  final int job;
  final int gender;
  final String user_name;
  final String email;
  final String token;

  LoginResponse.fromJson(Map<String,dynamic> json)
      : bir =json['bir'],
        email =json['email'],
        region =json['region'],
        job =json['job'],
        gender =json['gender'],
        token =json['token'],
        user_name =json['user_name'];
}