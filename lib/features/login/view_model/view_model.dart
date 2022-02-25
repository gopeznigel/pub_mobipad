import 'package:mobipad/exception/action_exception.dart';

import '../model.dart';
import '../state.dart';

class LoginPageViewModel {
  final LoginState _state;

  LoginPageViewModel(this._state);

  bool get isLoading => _state.isLoading;
  bool get googleSignIn => _state.googleSignIn;
  OhNotesUser get user => _state.user;
  ActionException get exception => _state.exception;
}
