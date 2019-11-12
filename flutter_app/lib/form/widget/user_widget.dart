import 'package:flutter/material.dart';
import 'package:flutter_app/form/response/User.dart';

class UserItem extends StatefulWidget {
  UserItem({this.user});

  final User user;

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                _buildImageUser(widget.user.thumbnailUrl),
                Positioned(
                    top: 5,
                    left: 5,
                    child: Icon(Icons.message, color: Colors.blue)),
                Positioned(
                    bottom: 5,
                    right: 5,
                    child: InkWell(
                        onTap: () {
                          isFavorite = !isFavorite;
                          setState(() {});
                        },
                        child: Icon(Icons.favorite,
                            color: isFavorite ? Colors.red : Colors.white))),
              ],
            ),
            SizedBox(height: 10),
            Text(widget.user.userName != null ? widget.user.userName : 'Hello'),
            SizedBox(height: 10),
            Text(widget.user.age != null ? widget.user.age.toString() : '18')
          ],
        ),
      ),
    );
  }

  _buildImageUser(String url) => url != null
      ? Image.network(
          url,
          fit: BoxFit.cover,
          height: 200,
        )
      : Image.asset(
          'assets/images/user_default.png',
          height: 200,
          fit: BoxFit.cover,
        );
}
