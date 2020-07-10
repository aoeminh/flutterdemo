import 'package:flutter_app/demoredux2/actions.dart';
import 'package:redux/redux.dart';

class LoadingMiddleware extends MiddlewareClass<int> {
  @override
  void call(Store<int> store, action, next) async {
    print('LoadingMiddleware - $action ');
    if(action is LoadingAction){
      await (Future.delayed(Duration(seconds: 2)));
      action.callback(true);
      var newState = store.state + 10;
      store.dispatch(UpdateAction(state: newState));
      action.callback(false);
    }
    next(action);
  }


}
