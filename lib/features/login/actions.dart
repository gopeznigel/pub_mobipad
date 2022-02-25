import 'package:flutter/foundation.dart';
import 'package:mobipad/features/login/model.dart';

import '../../exception/action_exception.dart';

@immutable
class OpenSignUpPage {
  @override
  String toString() => 'OpenSignUpPage';
}

@immutable
class OpenLoginPage {
  @override
  String toString() => 'OpenLoginPage';
}

@immutable
class CheckLoginStatus {
  @override
  String toString() => 'CheckLoginStatus';
}

@immutable
class CheckLoginStatusSucceeded {
  CheckLoginStatusSucceeded(this.userId, this.hasUserId)
      : assert(userId != null && hasUserId != null);

  final bool hasUserId;
  final String userId;

  @override
  String toString() =>
      'CheckLoginStatusSucceeded {hasToken: $hasUserId, userId: $userId}';
}

@immutable
class CheckLoginStatusFailed {
  CheckLoginStatusFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'CheckLoginStatusFailed {exception: $exception}';
}

@immutable
class Login {
  Login(this.email, this.password) : assert(email != null && password != null);

  final String email;
  final String password;

  @override
  String toString() => 'Login {email: $email}';
}

@immutable
class LoginSucceeded {
  LoginSucceeded(this.userId, this.hasUserId)
      : assert(userId != null && hasUserId != null);

  final bool hasUserId;
  final String userId;

  @override
  String toString() => 'LoginSucceeded {userId: $userId, hasToken: $hasUserId}';
}

@immutable
class LoginFailed {
  LoginFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'LoginFailed {exception: $exception}';
}

@immutable
class LoginUsingGoogle {
  @override
  String toString() => 'LoginUsingGoogle';
}

@immutable
class LoginUsingGoogleSucceeded {
  LoginUsingGoogleSucceeded(this.userId, this.hasUserId)
      : assert(userId != null && hasUserId != null);

  final bool hasUserId;
  final String userId;

  @override
  String toString() =>
      'LoginUsingGoogleSucceeded {userId: $userId, hasToken: $hasUserId}';
}

@immutable
class LoginUsingGoogleFailed {
  LoginUsingGoogleFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'LoginUsingGoogleFailed {exception: $exception}';
}

@immutable
class Logout {
  @override
  String toString() => 'Logout';
}

@immutable
class LogoutSucceeded {
  @override
  String toString() => 'LogoutSucceeded';
}

@immutable
class LogoutFailed {
  LogoutFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'LogoutFailed {exception: $exception}';
}

@immutable
class SignUp {
  SignUp(this.email, this.password) : assert(email != null && password != null);

  final String email;
  final String password;

  @override
  String toString() => 'SignUp';
}

@immutable
class SignUpSucceeded {
  SignUpSucceeded(this.userId, this.hasUserId)
      : assert(userId != null && hasUserId != null);

  final bool hasUserId;
  final String userId;

  @override
  String toString() => 'SignUpSucceeded {hasToken: $hasUserId}';
}

@immutable
class SignUpFailed {
  SignUpFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'SignUpFailed {exception: $exception}';
}

@immutable
class StoreUser {
  StoreUser(this.user) : assert(user != null);

  final OhNotesUser user;

  @override
  String toString() => 'StoreUser {user: $user}';
}

@immutable
class ClearUser {
  @override
  String toString() => 'ClearUser';
}

@immutable
class AccountInitDone {
  @override
  String toString() => 'AccountInitDone';
}
