import 'dart:math';

import 'package:flutter_app/demoredux2/actions.dart';

int reducers(int state, dynamic action) {
  print('reducers - $action - state - $state');
  if (action is IncreaseAction) {
    return increase(state);
  } else if (action is DecreaseAction) {
    return decrease(state);
  } else if (action is UpdateAction) {
    return state;
  } else {
    return state;
  }
}

int increase(int state) {
  state++;
  return state;
}

int decrease(int state) {
  state--;
  return state;
}
