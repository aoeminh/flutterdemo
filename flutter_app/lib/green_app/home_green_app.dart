import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/green_app/product_overview.dart';
import 'package:flutter_app/green_app/style_text.dart';

const int mainColor = 0xff279152;
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
    return MaterialApp(home: HomeGreen());
  }
}

class HomeGreen extends StatefulWidget {
  @override
  _HomeGreenState createState() => _HomeGreenState();
}

class _HomeGreenState extends State<HomeGreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(mainColor),
      body: Container(
        decoration: BoxDecoration(
          color: Color(mainColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(108))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _buildHeader(),
                      _buildBody(),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[_buildPlanting()],
                )),
          ],
        ),
      ),
    );
  }

  _buildHeader() => Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Icon(Icons.arrow_back_ios),
            SizedBox(
              height: 12,
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
        ),
      );

  _buildBody() => Container(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProductOverview()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: FloatingActionButton(
                      backgroundColor: Color(mainColor),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Image.asset(
                    'assets/images/green_tree.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  _buildPlanting() => Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15),
            Text(
              'Planting',
              style: Style.whiteTextWhiteNormal(),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[_buildWaterPlant(), _buildTempPlant()],
            )
          ],
        ),
      );

  _buildWaterPlant() => Container(
        height: 90,
        width: MediaQuery.of(context).size.width / 2 - 50,
        decoration: BoxDecoration(
            color: Color(0xf000000),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '250 ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                TextSpan(text: ' ml', style: Style.whiteTextWhiteNormal())
              ])),
              Text('water', style: Style.whiteTextWhiteNormal()),
            ],
          ),
        ),
      );

  _buildTempPlant() => Container(
        height: 90,
        width: MediaQuery.of(context).size.width / 2 - 50,
        decoration: BoxDecoration(
            color: Color(0xf000000),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(text: '18 ', style: Style.whiteTextBigBold()),
                TextSpan(text: ' C', style: Style.whiteTextWhiteNormal())
              ])),
              Text('sunshine', style: Style.whiteTextWhiteNormal()),
            ],
          ),
        ),
      );
}
