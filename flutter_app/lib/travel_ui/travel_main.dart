import 'package:flutter/material.dart';
import 'package:flutter_app/travel_ui/destination.dart';
import 'package:flutter_app/travel_ui/destination_detail.dart';
import 'package:flutter_app/travel_ui/destination_widget.dart';
import 'package:flutter_app/travel_ui/hotel.dart';
import 'package:flutter_app/travel_ui/hotel_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TravelMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TravelHome(),
    );
  }
}

class TravelHome extends StatefulWidget {
  @override
  _TravelHomeState createState() => _TravelHomeState();
}

class _TravelHomeState extends State<TravelHome> {
  List<IconData> icons = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.walking,
    FontAwesomeIcons.biking,
  ];

  int currentIconIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFFEEEEEE),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  _buildBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Text(
            'What you should you like find?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 30,
          ),
          _buildListIcon(),
          SizedBox(
            height: 30,
          ),
          _topTitle('Top Destinations'),
          SizedBox(
            height: 30,
          ),
          _listDestination(),
          SizedBox(
            height: 30,
          ),
          _topTitle('Top Hotels'),
          SizedBox(
            height: 30,
          ),
          _listHotels(),
          SizedBox(
            height: 30,
          ),
        ],
      );

  _buildListIcon() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: icons.map((icon) {
          return _buildItemIcon(icons.indexOf(icon));
        }).toList(),
      );

  Widget _buildItemIcon(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          currentIconIndex = index;
        });
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: currentIconIndex == index
                ? Color(0xFFBBDEFB)
                : Color(0xFFE0E0E0)),
        child: Icon(icons[index],
            color: currentIconIndex == index ? Color(0xFF64B5F6) : Colors.grey),
      ),
    );
  }

  _topTitle(String title) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            'See all',
            style: TextStyle(
                color: Color(0xFF64B5F6), fontWeight: FontWeight.bold),
          )
        ],
      );

  _listDestination() => Container(
        height: 300,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: destinations.length,
            itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DestinationDetail(
                                  destination: destinations[index],
                                )));
                  },
                  child: DestinationWidget(
                    destination: destinations[index],
                  ),
                )),
      );

  _listHotels() => Container(
        height: 400,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: hotels.length,
            itemBuilder: (BuildContext context, index) => HotelWidget(
                  hotels: hotels[index],
                )),
      );
}
