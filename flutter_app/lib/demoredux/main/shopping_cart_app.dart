import 'package:flutter/material.dart';
import 'package:flutter_app/demoredux/add_item/add_item_dialog.dart';
import 'package:flutter_app/demoredux/bottom_bar/bottom_cart_bar.dart';
import 'package:flutter_app/demoredux/list/shopping_list.dart';
import 'package:flutter_app/demoredux/model/app_state.dart';
import 'package:flutter_app/demoredux/redux/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';

import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

class ShoppingCartApp extends StatelessWidget {
  final Store<AppState> store;

  ShoppingCartApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'ShoppingList',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoreBuilder<AppState>(
            onInit: (store) => store.dispatch(FetchItemsAction()),
            builder: (context, store) => ShoppingCart(store)),
      ),
    );
  }
}

class ShoppingCart extends StatelessWidget {
  final Store<AppState> store;

  ShoppingCart(this.store);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShoppingList'),
      ),
      body: ShoppingList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddItemDialog(context),
        child: Icon(Icons.add),
      ),
      bottomSheet: BottomCartBar(),
//      endDrawer: Container(
//        width: 240.0,
//        color: Colors.white,
//        child: ReduxDevTools(store),
//      ),
    );
  }

  void _openAddItemDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AddItemDialog());
  }
}
