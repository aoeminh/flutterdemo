import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/demoredux2/actions.dart';
import 'package:flutter_app/demoredux2/change_value_screen.dart';
import 'package:flutter_app/demoredux2/reducer.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

import 'midleware.dart';


void main() {
  final store =
      Store<int>(reducers, initialState: 0, middleware: [LoadingMiddleware()]);
  runApp(ReduxApp(store: store));
}

class ReduxApp extends StatelessWidget {
  final Store store;

  const ReduxApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: store,
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: ReduxAppHome(),
      ),
    );
  }
}

class ReduxAppHome extends StatefulWidget {
//  final state;
//
//  const ReduxAppHome({Key key, this.state}) : super(key: key);
  @override
  _ReduxAppHomeState createState() => _ReduxAppHomeState();
}

class _ReduxAppHomeState extends State<ReduxAppHome> {

  bool isLoading;
  @override
  void initState() {
    super.initState();
    isLoading =false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StoreConnector<int, int>(
                  converter: (store) => store.state,
                  builder: (context, state) {
                    return Text('This is value: $state');
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                FlatButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChangeValueScreen())),
                  child: Text('Go to Change value screen'),
                ),
                SizedBox(
                  height: 50,
                ),
                StoreConnector<int, VoidCallback>(
                  converter: (store) => (){
                    store.dispatch(LoadingAction(callback: onStateChange));
                  },
                  builder: (context, callback) {
                    return FlatButton(
                      onPressed: callback,
                      child: Text(S.of(context).hello),
                    );
                  },
                )
              ],
            ),
          ),
          Offstage(
            offstage: !isLoading,
            child: Container(
              color: Colors.white.withOpacity(0.8),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

   onStateChange(bool isLoading){
    print('onStateChange $isLoading');
    setState(() {
      this.isLoading = isLoading;
    });
  }
}

typedef OnStateChange = Function(bool isLoading);
