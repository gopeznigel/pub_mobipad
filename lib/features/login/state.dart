import 'package:mobipad/exception/action_exception.dart';

import 'model.dart';

class LoginState {
  bool isLoading;
  bool googleSignIn;
  OhNotesUser user;
  ActionException exception;
  bool newLogin;

  LoginState(
      {this.isLoading,
      this.googleSignIn,
      this.user,
      this.exception,
      this.newLogin});

  LoginState.initial()
      : isLoading = false,
        googleSignIn = false,
        user = null,
        newLogin = null,
        exception = null;
}
