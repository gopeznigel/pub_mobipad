import 'package:flutter/foundation.dart';
import 'package:mobipad/exception/action_exception.dart';

@immutable
class SendResetPasswordLink {
  const SendResetPasswordLink(this.email);

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
  const SendResetPasswordLinkFailed(this.exception);

  final ActionException exception;

  @override
  String toString() => 'SendResetPasswordLinkFailed {exception: $exception}';
}
