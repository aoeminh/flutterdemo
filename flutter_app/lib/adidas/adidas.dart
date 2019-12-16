import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double baseHeight = 640.0;
const String desc =
    "Get maximum support, comfort and a refreshed look with these adidas energy cloud shoes for men comes wit a classic style."
    "Boost your running comfort to the next level with this supportive shoe Synthetic upper with FITFRAME midfoot cage for a locked-down fit and feel"
    "Lace-up closure Cushioned footbed CLOUDFOAM midsole provides responsive padding Durable ADIWEAR™ rubber sole.";

List<String> sizeList = ["7", "8", "9", "10"];
List<Color> colors = [
  Color(0xFFF9362E),
  Color(0xFF003CFF),
  Color(0xFFFFB73A),
  Color(0xFF3AFFFF),
  Color(0xFF1AD12C),
  Color(0xFFD66400),
];

class AdidasMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Adidas'),
          centerTitle: true,
          leading: Icon(Icons.arrow_back),
        ),
        body: AdidasHome(),
      ),
    );
  }
}

class AdidasHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AdidasHomeState();
  }
}

class _AdidasHomeState extends State<AdidasHome> {
  bool isExpanded = false;
  int currentSizeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return body();
  }

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

  body() =>
      SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF696D77), Color(0xFF292C36)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                  child: Image.asset(
                    'assets/images/adidas.png',
                    width: double.infinity,
                    height: screenAwareSize(245, context),
                    fit: BoxFit.cover,
                  )),
              rating(),
              SizedBox(
                height: 20,
              ),
              description(),
              SizedBox(
                height: 20,
              ),
              _sizeAndQuantity()
            ],
          ),
        ),
      );

  rating() =>
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Rating',
              style: TextStyle(
                color: Color(0xFF949598),
                fontSize: screenAwareSize(10.0, context),
                fontFamily: "Montserrat-SemiBold",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenAwareSize(26.0, context),
                  right: screenAwareSize(18.0, context)),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '4.5',
                          style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: ' (45k rating)',
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  description() =>
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Product Description',
                style: TextStyle(
                  color: Color(0xFF949598),
                  fontSize: screenAwareSize(10.0, context),
                  fontFamily: "Montserrat-SemiBold",
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: screenAwareSize(26.0, context),
                  right: screenAwareSize(18.0, context)),
              child: AnimatedCrossFade(
                firstChild: Text(
                  desc,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenAwareSize(10.0, context),
                      fontFamily: "Montserrat-Medium"),
                ),
                secondChild: Text(
                  desc,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenAwareSize(10.0, context),
                      fontFamily: "Montserrat-Medium"),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: kThemeAnimationDuration,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenAwareSize(26.0, context),
                  right: screenAwareSize(18.0, context)),
              child: GestureDetector(
                  onTap: _expand,
                  child: Text(
                    isExpanded ? "less" : "more..",
                    style: TextStyle(
                        color: Color(0xFFFB382F), fontWeight: FontWeight.w700),
                  )),
            ),
          ],
        ),
      );

  _sizeAndQuantity() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _size(),
        ],
      );

  _size() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Size',
              style: TextStyle(
                color: Color(0xFF949598),
                fontSize: screenAwareSize(10.0, context),
                fontFamily: "Montserrat-SemiBold",
              )),
          Padding(
            padding: EdgeInsets.only(
                left: screenAwareSize(26.0, context),
                right: screenAwareSize(18.0, context,)
            ),
            child: Row(
              children: sizeList.map((item) {
                return itemSize(item, sizeList.indexOf(item));
              }).toList(),
            ),
          )
        ],
      );

  Widget itemSize(String size, int index) =>
      InkWell(
        onTap: () {
          setState(() {
            currentSizeIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: currentSizeIndex == index ? Colors.red : Colors.grey,
          ),
          margin: EdgeInsets.all(5),
          height: screenAwareSize(30, context),
          width: screenAwareSize(30, context),
          child: Center(child: Text(size)),
        ),
      );

  _quantity() =>
      Column(
        children: <Widget>[
          Text('Product Description',
              style: TextStyle(
                color: Color(0xFF949598),
                fontSize: screenAwareSize(10.0, context),
                fontFamily: "Montserrat-SemiBold",
              )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[],
          )
        ],
      );

  double screenAwareSize(double size, BuildContext context) {
    return size * MediaQuery
        .of(context)
        .size
        .height / baseHeight;
  }
}
