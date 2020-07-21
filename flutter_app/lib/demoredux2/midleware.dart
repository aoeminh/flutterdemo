import 'package:flutter_app/demoredux2/actions.dart';
import 'package:redux/redux.dart';

class LoadingMiddleware extends MiddlewareClass<int> {
  @override
  Future<void> call(Store<int> store, action, next) async {
    print('LoadingMiddleware - $action ');
    int oldState = store.state;
    if(action is LoadingAction){
      action.callback(true);
      await (Future.delayed(Duration(seconds: 2)));

      print(' ssold $oldState');
      int newState = oldState + 10;
      print(' new $newState');

      store.dispatch(UpdateAction(count: newState));
      action.callback(false);
      return;
    }
    next(action);
  }


}
