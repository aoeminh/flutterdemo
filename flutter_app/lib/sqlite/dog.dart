class Dog {
  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() => <String, dynamic>{'name': name, 'age': age};

  factory Dog.fromJson(Map<String, dynamic> json) =>
      Dog(id: json['id'], name: json['name'], age: json['age']);

  int id;
  String name;
  int age;
}
