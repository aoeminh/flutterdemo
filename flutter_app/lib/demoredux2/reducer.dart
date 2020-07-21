import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/demoredux2/actions.dart';
import 'package:redux/redux.dart';

//int reducers(int state, dynamic action) {
//  print('reducers - $action - state - $state');
//  if (action is IncreaseAction) {
//    return increase(state);
//  } else if (action is DecreaseAction) {
//    return decrease(state);
//  } else if (action is UpdateAction) {
//    return update(action);
//  } else {
//    return state;
//  }
//}

final reducers = combineReducers<int>([
  TypedReducer<int, IncreaseAction>(_onIncrease),
  TypedReducer<int, DecreaseAction>(_onDecrease),
  TypedReducer<int, UpdateAction>(_onUpdate),
]);

int _onIncrease(int state, IncreaseAction action) => increase(state);

int _onDecrease(int state, DecreaseAction action) => decrease(state);

int _onUpdate(int state, UpdateAction action) => update(action);

int increase(int state) {
  state++;
  return state;
}

int decrease(int state) {
  state--;
  return state;
}

int update(UpdateAction action) {
  return action.count;
}
