class Message {
  Message({this.content, this.id, this.isOwner, this.time, this.userName});

  String id;
  String userName;
  String content;
  bool isOwner;
  int time ;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'userName': userName,
        'content': content,
        'isOwner': isOwner,
        'time': time
      };

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(
          id: json['id'],
          userName: json['userName'],
          content: json['content'],
          isOwner: json['isOwner'],
          time: json['time']

      );
}
