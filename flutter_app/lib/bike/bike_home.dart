import 'package:flutter/material.dart';

class BikeMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BikeHome(),
    );
  }
}

class BikeHome extends StatefulWidget {
  @override
  _BikeHomeState createState() => _BikeHomeState();
}

class _BikeHomeState extends State<BikeHome> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    print('init state');
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(BikeHome oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('resumed');
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print('resumed');
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.paused:
        print('paused');
        break;
      case AppLifecycleState.detached:
        print('detached');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 2 / 3,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 300,
                  padding: EdgeInsets.only(left: 30, top: 50),
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xfffec5c4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Bicycle',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'BMK K30',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 150,
                  right: 100,
                  left: -50,
                  child: Image.asset('assets/images/bike.png'),
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Amazing Speed.',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Incredible Power.',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
