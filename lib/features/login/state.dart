import 'package:built_value/built_value.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/login/dtos.dart';

part 'state.g.dart';

abstract class LoginState implements Built<LoginState, LoginStateBuilder> {
  factory LoginState([void Function(LoginStateBuilder b) updates]) =
      _$LoginState;

  factory LoginState.initial() => _$LoginState._(
        status: LoginStatusEnum.initial,
      );

  LoginState._();

  LoginStatusEnum get status;
  UserDto? get user;
  ActionException? get exception;
}
