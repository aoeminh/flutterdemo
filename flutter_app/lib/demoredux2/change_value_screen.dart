import 'package:flutter/material.dart';
import 'package:flutter_app/demoredux2/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ChangeValueScreen extends StatefulWidget {
  @override
  _ChangeValueScreenState createState() => _ChangeValueScreenState();
}

class _ChangeValueScreenState extends State<ChangeValueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change value screen'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            StoreConnector<int, VoidCallback>(
              converter: (store) => (){
                print('store - ${store.state}');
                store.dispatch(IncreaseAction(count: store.state));},
              builder: (context, callback){
                return FlatButton(
                  onPressed: callback,
                  child: Text('Increase'),
                );
              },
            ),
            SizedBox(height: 50,),
            StoreConnector<int, VoidCallback>(
              converter: (store) => (){store.dispatch(DecreaseAction(count: store.state));},
              builder: (context, callback){
                return FlatButton(
                  onPressed: callback,
                  child: Text('Decrease'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
