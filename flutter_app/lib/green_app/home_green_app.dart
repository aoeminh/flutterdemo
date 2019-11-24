import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/green_app/product_overview.dart';
import 'package:flutter_app/green_app/style_text.dart';

const int mainColor = 0xff008700;
const Color transparent = Color(0xf000000);

class Main extends StatelessWidget {
  Main() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(

        //top bar color
        statusBarColor: Colors.transparent,
        //top bar icons
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light));
  }

 BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MaterialApp(
      home: HomeGreen()
    );
  }


}

class HomeGreen extends StatefulWidget{

  @override
  _HomeGreenState createState() => _HomeGreenState();
}

class _HomeGreenState extends State<HomeGreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(mainColor),
        ),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Color(mainColor)),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30),
                      _buildHeader(),
                      _buildBody(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                _buildPlanting()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildHeader() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Icon(Icons.arrow_back_ios),
      SizedBox(
        height: 20,
      ),
      Container(
        width: 250,
        child: Text(
          'Fiddle Lead Fig Topiary',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        '10 Nusery',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      ),
      SizedBox(
        height: 10,
      ),
      RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
            text: '\$ ',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.green),
          ),
          TextSpan(
              text: '85',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green))
        ]),
      ),
    ],
  );

  _buildBody() => Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    height: 250,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductOverview()));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Color(mainColor),
                borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Image.asset(
            'assets/images/green_tree.png',
            fit: BoxFit.fitHeight,
          ),
        )
      ],
    ),
  );

  _buildPlanting() => Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Planting',
          style: Style.whiteTextWhiteNormal(),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[_buildWaterPlant(), _buildTempPlant()],
        )
      ],
    ),
  );

  _buildWaterPlant() => Container(
    padding: EdgeInsets.all(30),
    decoration: BoxDecoration(
        color: Color(0xf000000),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    child: Center(
      child: Column(
        children: <Widget>[
          RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '250 ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: ' ml',
                    style: Style.whiteTextWhiteNormal())
              ])),
          Text('water',
              style: Style.whiteTextWhiteNormal()),
        ],
      ),
    ),
  );

  _buildTempPlant() => Container(
    padding: EdgeInsets.all(30),
    decoration: BoxDecoration(
        color: Color(0xf000000),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    child: Center(
      child: Column(
        children: <Widget>[
          RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '18 ',
                    style: Style.whiteTextBigBold()),
                TextSpan(
                    text: ' C',
                    style: Style.whiteTextWhiteNormal())
              ])),
          Text('sunshine',
              style: Style.whiteTextWhiteNormal()
          ),
        ],
      ),
    ),
  );
}
