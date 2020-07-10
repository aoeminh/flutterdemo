import 'package:flutter/material.dart';
import 'main/shopping_cart_app.dart';
import 'redux/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await createReduxStore();
  runApp(ShoppingCartApp(store));
}
