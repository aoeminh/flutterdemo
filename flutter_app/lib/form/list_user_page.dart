import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/form/request/getListUserRequest.dart';
import 'package:flutter_app/form/response/User.dart';
import 'package:flutter_app/form/share_preferent.dart';
import 'package:flutter_app/form/widget/user_widget.dart';
import 'package:dio/dio.dart';

final String _endpoint = "http://10.64.100.22:9119";

class ListUserPage extends StatefulWidget {
  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage>  {
  List<User> list = List();


  @override
  void initState() {
    super.initState();
     _getUserList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text('List user'),
        ),
        body: _buildGridView());
  }

  _buildGridView() => Container(
        color: Colors.black12,
        padding: EdgeInsets.all(5),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 3 / 4,
          children: list.map((item) {
            return KeepAliveWidget(child: UserItem(user: item));
          }).toList(),
        ),
      );

  _getUserList() async {
    String token = await UserPrefs.getToken();
    GetListUserRequest request = GetListUserRequest(token: token);
    Dio dio = Dio();
    Response response = await dio.post(_endpoint, data: request.toJson());
    print(response);
    Map<String, dynamic> map = jsonDecode(response.toString());
    Iterable data = map['data'];
    list = data.map((user) => User.fromJson(user)).toList();
    setState(() {});
  }

  _goBack(){
    Navigator.canPop(context);
  }
}
class KeepAliveWidget extends StatefulWidget {
  const KeepAliveWidget({this.child});

  final Widget child;

  @override
  _KeepAliveWidgetState createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}