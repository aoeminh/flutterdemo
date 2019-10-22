import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Card demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Card demo'),

        ),
        body:_buildCard() ,
      ),
    );
  }

  Widget _buildCard() => SizedBox(
    height: 240,
    child: Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.restaurant_menu,color: Colors.blue,),
            title: Text(
              '1625 Main Street',
                style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('My City, CA 99984'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contact_phone,color: Colors.blue,),
            title: Text(
              '(408) 555-1212',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('My City, CA 99984'),
          ),
          ListTile(
            leading: Icon(Icons.contact_mail,color: Colors.blue,),
            title: Text(
              '(osta@example.com',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('My City, CA 99984'),
          )
        ],
      ),
    ),
  );

}