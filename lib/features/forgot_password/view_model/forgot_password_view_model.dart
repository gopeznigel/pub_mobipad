import 'package:mobipad/exception/action_exception.dart';

import '../state.dart';

class ForgotPasswordPageViewModel {
  final ForgotPasswordState _state;

  ForgotPasswordPageViewModel(this._state);

  bool get isSending => _state.isSending;
  ActionException get exception => _state.exception;
}
