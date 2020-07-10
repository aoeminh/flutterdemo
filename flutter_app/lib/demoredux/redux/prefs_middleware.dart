import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/demoredux/model/app_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'actions.dart';

const String APP_STATE_KEY = "APP_STATE";

class PrefsMiddleware extends MiddlewareClass<AppState> {
  final SharedPreferences preferences;

  PrefsMiddleware(this.preferences);

  @override
  Future<void> call(Store<AppState> store, action, NextDispatcher next) async {
    print('PrefsMiddleware - $action');
    if (action is AddItemAction ||
        action is ToggleItemStateAction ||
        action is RemoveItemAction) {
      await _saveStateToPrefs(store.state);
    }

    if (action is FetchItemsAction) {
      await _loadStateFromPrefs(store);
    }

    next(action);
  }

  Future _saveStateToPrefs(AppState state) async {
    var stateString = json.encode(state.toJson());
    await preferences.setString(APP_STATE_KEY, stateString);
  }

  Future _loadStateFromPrefs(Store<AppState> store) async {
    var stateString = preferences.getString(APP_STATE_KEY);
    if (stateString == null) return;
    var state = AppState.fromJson(json.decode(stateString));
    store.dispatch(ItemLoadedAction(state.cartItems));
  }
}
