import 'package:flutter/foundation.dart';
import 'package:mobipad/exception/action_exception.dart';

@immutable
class SendResetPasswordLink {
  SendResetPasswordLink(this.email) : assert(email != null);

  final String email;

  @override
  String toString() => 'SendResetPasswordLink {email: $email}';
}

@immutable
class SendResetPasswordLinkSucceeded {
  @override
  String toString() => 'SendResetPasswordLinkSucceeded';
}

@immutable
class SendResetPasswordLinkFailed {
  SendResetPasswordLinkFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'SendResetPasswordLinkFailed {exception: $exception}';
}
