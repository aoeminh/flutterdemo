import 'package:dio/dio.dart';

void main() async {
  BaseOptions baseOptions =
      BaseOptions(baseUrl: 'https://randomuser.me/', method: 'GET');
  Dio dio = Dio(baseOptions);
  Response response = await dio.request('api/',
      onReceiveProgress: onReceiveProgressCallback,
      onSendProgress: onSendProgressCallback);
  UserResponse userResponse = UserResponse.fromJson(response.data);
  print('${userResponse.result[0].name.title}');
}

onReceiveProgressCallback(int count, int total) {
  print('onReceiveProgressCallback count- $count total - $total');
}

onSendProgressCallback(int count, int total) {
  print('onSendProgressCallback count- $count total - $total');
}




class UserResponse {
  List<User> result;
  UserResponse({this.result});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
      result: List<User>.from(json['results'].map((x) => User.fromJson(x))));
}

class User {
  Name name;
  String email;
  String phone;

  User({this.name, this.email, this.phone});

  factory User.fromJson(Map<String, dynamic> json) => User(
      email: json['email'],
      phone: json['phone'],
      name: Name.fromJson(json['name']));
}

class Name {
  final String title;
  final String first;
  final String last;

  Name({this.title, this.first, this.last});

  factory Name.fromJson(Map<String, dynamic> json) =>
      Name(title: json['title'], first: json['first'], last: json['last']);
}
