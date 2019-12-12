import 'package:flutter/material.dart';
import 'package:flutter_app/green_app/home_green_app.dart';
import 'package:flutter_app/green_app/style_text.dart';

typedef ButtonClick();

class ProductOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 25),
        color: Color(mainColor),
        child: _buildBody(),
      ),
    );
  }
  BuildContext context;
  _buildBody() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 30,
      ),
      _buildTopRow(),
      SizedBox(
        height: 50,
      ),
      //title
      Container(
        width: 200,
        child: Text(
          'Product overview',
          style: Style.whiteTextBigBold(),
        ),
      ),
      //water
      SizedBox(
        height: 50,
      ),
      buildRowContent('Water', 'every 7 days'),
      SizedBox(
        height: 10,
      ),
      buildRowContent('Humidity', 'up to 82%'),
      SizedBox(
        height: 10,
      ),
      buildRowContent('Size', '38-48'),
      SizedBox(
        height: 50,
      ),
      _buildBottomButton('Delivery Infomation', () {
        print('Delivery click');
      }),
      SizedBox(
        height: 20,
      ),
      _buildBottomButton('Return Policy', () {
        print('Policy click');
      }),
//            SizedBox(
//              height: 60,
//            ),
//
    Spacer(),
      buildFooter()
    ],
  );

  _buildTopRow() => Container(

        padding: EdgeInsets.only(right: 25),
        child: Row(
          children: <Widget>[

            SizedBox(width: 10),
            Text(
              'greenery nyc',
              style: TextStyle(color: Colors.white, fontSize: 15),
            )
          ],
        ),
      );

  buildRowContent(String title, String content) => Container(
        padding: EdgeInsets.only(right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.ac_unit,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(title, style: Style.whiteTextWhiteNormalBold())
              ],
            ),
            Text(
              content,
              style: Style.whiteTextWhiteNormal(),
            )
          ],
        ),
      );

  _buildBottomButton(String title, ButtonClick buttonClick) => Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: buttonClick,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: transparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      title,
                      style: Style.whiteTextWhiteNormalBold(),
                    )),
              ],
            ),
          ),
        ),
      );

  buildFooter() => Row(
        children: <Widget>[
          Expanded(
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 25,left: 25,bottom: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
                  color: Colors.black),
              child: Row(children: <Widget>[
                Icon(Icons.shopping_cart,color: Colors.white,),
                SizedBox(width: 10,),
                Text('add to cart',style: Style.whiteTextWhiteNormal(),)
              ]),
            ),
          )
        ],
      );
}

