import 'package:flutter/foundation.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/login/dtos.dart';

@immutable
class CheckLoginStatus {
  @override
  String toString() => 'CheckLoginStatus';
}

@immutable
class CheckLoginStatusSucceeded {
  const CheckLoginStatusSucceeded({this.user});

  final UserDto? user;

  @override
  String toString() => 'CheckLoginStatusSucceeded {user: $user}';
}

@immutable
class CheckLoginStatusFailed {
  const CheckLoginStatusFailed({required this.exception});

  final ActionException exception;

  @override
  String toString() => 'CheckLoginStatusFailed {exception: $exception}';
}

@immutable
class SignUp {
  const SignUp({required this.email, required this.password});

  final String email;
  final String password;

  @override
  String toString() =>
      'SignUp {email: $email, password: passwordHiddenOfCourse}';
}

@immutable
class SignUpSucceeded {
  const SignUpSucceeded({required this.user});

  final UserDto user;

  @override
  String toString() => 'SignUpSucceeded {user: $user}';
}

@immutable
class SignUpFailed {
  const SignUpFailed({required this.exception});

  final ActionException exception;

  @override
  String toString() => 'SignUpFailed {exception: $exception}';
}

@immutable
class Login {
  const Login({required this.email, required this.password});

  final String email;
  final String password;

  @override
  String toString() => 'Login {email: $email}';
}

@immutable
class LoginSucceeded {
  const LoginSucceeded({required this.user});

  final UserDto user;

  @override
  String toString() => 'LoginSucceeded {user: $user}';
}

@immutable
class LoginFailed {
  const LoginFailed({required this.exception});

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
  const LoginUsingGoogleSucceeded({required this.user});

  final UserDto user;

  @override
  String toString() => 'LoginUsingGoogleSucceeded {user: $user}';
}

@immutable
class LoginUsingGoogleFailed {
  const LoginUsingGoogleFailed({required this.exception});

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
  const LogoutFailed({required this.exception});

  final ActionException exception;

  @override
  String toString() => 'LogoutFailed {exception: $exception}';
}
