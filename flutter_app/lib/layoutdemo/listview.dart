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
        body: listBuilder(),
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

  GestureDetector _tile(String title, String subTitle, IconData icon) =>
      GestureDetector(
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
        onTap: () {
          Fluttertoast.showToast(
              msg: '$title',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              fontSize: 16.0);
        },
      );

  // create list with Listview.builder
  final items = List<ListItem>.generate(
    120,
    (i) => i % 6 == 0
        ? HeadingItem("Heading $i")
        : MessageItem("Sender $i", "Message body $i"),
  );

  Widget listBuilder() => ListView.builder(
        itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];

      if (item is HeadingItem) {
        return ListTile(
          title: Text(
            item.heading,
            style: Theme.of(context).textTheme.headline,
          ),
        );
      } else if (item is MessageItem) {
        return ListTile(
          title: Text(item.sender),
          subtitle: Text(item.body),
        );
      }
      return ListTile(title: Text('undefine'),
      );
    },
      );
}

abstract class ListItem {}

// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
