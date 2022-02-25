import 'package:mobipad/exception/action_exception.dart';

class ForgotPasswordState {
  bool isSending;
  ActionException exception;

  ForgotPasswordState({this.isSending, this.exception});

  ForgotPasswordState.initial()
      : isSending = false,
        exception = null;
}
