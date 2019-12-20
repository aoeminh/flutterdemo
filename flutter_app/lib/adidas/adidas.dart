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
  int _quantityProduct = 0;
  int currentColorIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  void _expand() {
    setState(() {
      isExpanded = !isExpanded;
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
              SizedBox(height: 10),
              Container(
                  child: Image.asset(
                    'assets/images/adidas.png',
                    width: double.infinity,
                    height: screenAwareSize(230, context),
                    fit: BoxFit.cover,
                  )),
              rating(),
              SizedBox(
                height: 10,
              ),
              description(),
              SizedBox(
                height: 10,
              ),
              _sizeAndQuantity(),
              SizedBox(
                height: 10,
              ),
              _color(),
              SizedBox(
                height: 10,
              ),
              _price()

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
            SizedBox(
              height: 10,
            ),
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
        children: <Widget>[_size(), _quantity(),
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
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenAwareSize(26.0, context),
                right: screenAwareSize(
                  18.0,
                  context,
                )),
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
            color: currentSizeIndex == index ? Colors.red : Color(0xFF525663),
          ),
          margin: EdgeInsets.all(5),
          height: screenAwareSize(30, context),
          width: screenAwareSize(30, context),
          child: Center(child: Text(size)),
        ),
      );

  _quantity() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Quantity',
              style: TextStyle(
                color: Color(0xFF949598),
                fontSize: screenAwareSize(10.0, context),
                fontFamily: "Montserrat-SemiBold",
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenAwareSize(26.0, context),
                right: screenAwareSize(
                  18.0,
                  context,
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: _decrease,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 1),
                    height: screenAwareSize(30, context),
                    width: screenAwareSize(30, context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color(0xFF525663),
                    ),
                    child: Center(
                      child: Text('-',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenAwareSize(20.0, context),
                            fontFamily: "Montserrat-SemiBold",
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color(0xFF525663),
                  ),
                  height: screenAwareSize(30, context),
                  width: screenAwareSize(30, context),
                  child: Center(
                    child: Text(_quantityProduct.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenAwareSize(15.0, context),
                          fontFamily: "Montserrat-SemiBold",
                        )),
                  ),
                ),
                InkWell(
                  onTap: _increase,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color(0xFF525663),
                    ),
                    height: screenAwareSize(30, context),
                    width: screenAwareSize(30, context),
                    child: Center(
                      child: Text('+',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenAwareSize(20.0, context),
                            fontFamily: "Montserrat-SemiBold",
                          )),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );

  _increase() {
    print('_increase $_quantityProduct');
    setState(() {
      print('_increase $_quantityProduct');
      if (_quantityProduct < 10) {
        _quantityProduct++;
      } else {
        _quantityProduct = 10;
      }
    });
  }

  _decrease() {
    print('_decrease $_quantityProduct');
    setState(() {
      if (_quantityProduct > 0) {
        _quantityProduct--;
      } else {
        _quantityProduct = 0;
      }
    });
  }

  Widget _color() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Select Color',
            style: TextStyle(
              color: Color(0xFF949598),
              fontSize: screenAwareSize(10.0, context),
              fontFamily: "Montserrat-SemiBold",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenAwareSize(26.0, context),
                right: screenAwareSize(
                  18.0,
                  context,
                )),
            child: Row(children: colors.map((item) {
              return _itemColor(
                  item, currentColorIndex == colors.indexOf(item), () {
                setState(() {
                  currentColorIndex = colors.indexOf(item);
                });
              });
            }).toList()),
          ),
        ],
      );

  Widget _itemColor(Color color, bool isSelected, VoidCallback onTap) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: screenAwareSize(30, context),
          height: screenAwareSize(30, context),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)), color: color),
          child: Offstage(
              offstage: !isSelected,
              child: Center(child: Icon(Icons.check, color: Colors.black,),)),
        ),
      );

  _price() =>
      Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Price',
                  style: TextStyle(
                    color: Color(0xFF949598),
                    fontSize: screenAwareSize(10.0, context),
                    fontFamily: "Montserrat-SemiBold",
                  )
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenAwareSize(26.0, context),
                    right: screenAwareSize(
                      18.0,
                      context,
                    )),
                child: Text('\$80',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenAwareSize(30.0, context),
                      fontFamily: "Montserrat-SemiBold",
                    )
                ),
              ),
              SizedBox(height: 10,),
              Container(

                height: screenAwareSize(35, context),
                padding: EdgeInsets.only(left: 35),
                decoration: BoxDecoration(
                  color: Color(0xFFFB382F),
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Center(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Add To Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenAwareSize(15.0, context),
                          fontFamily: "Montserrat-SemiBold",
                          fontWeight: FontWeight.bold
                        )),
                  )
                ),
              )
            ],
          ),
          Positioned(
            right: -40.0,
            bottom: -70.0,
            height: screenAwareSize(150, context),
            width: screenAwareSize(190, context),
            child: Image.asset('assets/images/cart.png'),
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
