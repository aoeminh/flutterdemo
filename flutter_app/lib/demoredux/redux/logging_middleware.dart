import 'package:flutter_app/demoredux/model/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

class LoggingMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    print('LoggingMiddleware - $action');
    next(action);

    if (action is! Store) {
      print('Action: $action');
      print('State: ${store.state.toJson()}');
    }
  }
}

