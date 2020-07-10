import 'main.dart';

class IncreaseAction {
  final count;

  IncreaseAction({this.count});
}

class DecreaseAction {
  final count;

  DecreaseAction({this.count});
}

class LoadingAction {
  final OnStateChange callback;

  LoadingAction({this.callback});
}

class UpdateAction {
  final int state;

  UpdateAction({this.state});
}
