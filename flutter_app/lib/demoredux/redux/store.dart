import 'package:flutter_app/demoredux/data/api_client.dart';
import 'package:flutter_app/demoredux/model/app_state.dart';
import 'package:flutter_app/demoredux/redux/prefs_middleware.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_middleware.dart';
import 'logging_middleware.dart';
import 'reducers.dart';

Future<Store<AppState>> createReduxStore() async {
  final apiClient = ApiClient();
  var sharedPreferences = await SharedPreferences.getInstance();
  return Store<AppState>(
    appStateReducers,
    initialState: AppState.empty(),
    middleware: [
      ApiMiddleware(apiClient),
      PrefsMiddleware(sharedPreferences),
      LoggingMiddleware(),
    ],
  );
}
