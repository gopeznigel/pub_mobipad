import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/login/dtos.dart';

import '../dtos.dart';
import '../state.dart';

class LoginPageViewModel {
  final LoginState _state;

  LoginPageViewModel(this._state);

  UserDto? get user => _state.user;
  String get userEmail => user?.email ?? '';
  String get userId => user?.userId ?? '';
  LoginStatusEnum get status => _state.status;
  ActionException? get exception => _state.exception;
  String get error => exception?.exception?.toString() ?? '';
}
