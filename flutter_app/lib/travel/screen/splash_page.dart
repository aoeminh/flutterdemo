import 'package:flutter/material.dart';
import 'package:flutter_app/travel/firebase/authetication.dart';
import 'package:flutter_app/travel/screen/home_page.dart';

import 'sign_in_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Authentication.instance.firebaseAuth().currentUser().then((user) {
      if(user !=null){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TravelHome(uid: user.uid,)),(r)=>false);
      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignIn()),(r) => false);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
