
import 'package:flutter_app/demoredux/data/api_client.dart';
import 'package:flutter_app/demoredux/model/app_state.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

class ApiMiddleware extends MiddlewareClass<AppState> {
  final ApiClient apiClient;

  ApiMiddleware(this.apiClient);

  @override
  Future call(Store<AppState> store, action, NextDispatcher next) async {
    print('ApiMiddleware - $action');
    if (action is FetchCartItemsAction) {
      return _fetchCartItems(store, action);
    }

    next(action);
  }

  Future _fetchCartItems(
      Store<AppState> store, FetchCartItemsAction action) async {
    action.callback(true);
    var cartItems = await apiClient.fetchCartItems();
    store.dispatch(ItemLoadedAction(cartItems));
    action.callback(false);
  }
}
