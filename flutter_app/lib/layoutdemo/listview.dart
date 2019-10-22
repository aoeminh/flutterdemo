import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ListViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Listview Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Listview Demo'),

        ),

        body: _buildListView(),
      ),
    );
  }

  Widget _buildListView() => ListView(
        children: [
          _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
          Divider(),
          _tile('The Castro Theater', '429 Castro St', Icons.theaters),
          Divider(),
          _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
          Divider(),
          _tile('Roxie Theater', '3117 16th St', Icons.theaters),
          Divider(),
          _tile('United Artists Stonestown Twin', '501 Buckingham Way',

              Icons.theaters),
          Divider(),
          _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
          Divider(),
          _tile('Kescaped_code#39;s Kitchen', '757 Monterey Blvd',

              Icons.restaurant),
          Divider(),
          _tile('Emmyescaped_code#39;s Restaurant', '1923 Ocean Ave',

              Icons.restaurant),
          Divider(),
          _tile(
              'Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
          Divider(),
          _tile('La Ciccia', '291 30th St', Icons.restaurant),
        ],
      );

  GestureDetector _tile(String title, String subTitle, IconData icon) => GestureDetector(
    child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: Icon(
            icon,
            color: Colors.green,
          ),
        ),
    onTap: (){
      Fluttertoast.showToast(
          msg: '$title',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
    },
  );
}
