import 'package:mobipad/features/login/dtos.dart';
import 'package:mobipad/features/login/state.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

final Reducer<LoginState> loginStateReducer = combineReducers([
  TypedReducer<LoginState, CheckLoginStatusSucceeded>(
      _handleCheckLoginStatusSucceeded),
  TypedReducer<LoginState, Login>(_loginReducer),
  TypedReducer<LoginState, LoginSucceeded>(_loginSucceededReducer),
  TypedReducer<LoginState, LoginFailed>(_loginFailedReducer),
  TypedReducer<LoginState, SignUp>(_signUpReducer),
  TypedReducer<LoginState, SignUpSucceeded>(_signUpSucceededReducer),
  TypedReducer<LoginState, SignUpFailed>(_signUpFailedReducer),
  TypedReducer<LoginState, LoginUsingGoogle>(_loginUsingGoogleReducer),
  TypedReducer<LoginState, LoginUsingGoogleSucceeded>(
      _loginUsingGoogleSucceededReducer),
  TypedReducer<LoginState, LoginUsingGoogleFailed>(
      _loginUsingGoogleFailedReducer),
]);

LoginState _handleCheckLoginStatusSucceeded(
        LoginState state, CheckLoginStatusSucceeded action) =>
    state.rebuild((b) {
      if (action.user != null) {
        return b..user.replace(action.user!);
      } else {
        return b..user = null;
      }
    });

LoginState _loginReducer(LoginState state, Login action) =>
    state.rebuild((b) => b
      ..status = LoginStatusEnum.loading
      ..exception = null);

LoginState _loginSucceededReducer(LoginState state, LoginSucceeded action) =>
    state.rebuild((b) => b
      ..status = LoginStatusEnum.done
      ..user.replace(action.user));

LoginState _loginFailedReducer(LoginState state, LoginFailed action) =>
    state.rebuild((b) => b
      ..status = LoginStatusEnum.done
      ..exception = action.exception);

LoginState _signUpReducer(LoginState state, SignUp action) =>
    state.rebuild((b) => b
      ..status = LoginStatusEnum.loading
      ..exception = null);

LoginState _signUpSucceededReducer(LoginState state, SignUpSucceeded action) =>
    state.rebuild((b) => b
      ..status = LoginStatusEnum.done
      ..user.replace(action.user));

LoginState _signUpFailedReducer(LoginState state, SignUpFailed action) =>
    state.rebuild((b) => b
      ..status = LoginStatusEnum.done
      ..exception = action.exception);

LoginState _loginUsingGoogleReducer(
        LoginState state, LoginUsingGoogle action) =>
    state.rebuild((b) => b
      ..status = LoginStatusEnum.loading
      ..exception = null);

LoginState _loginUsingGoogleSucceededReducer(
        LoginState state, LoginUsingGoogleSucceeded action) =>
    state.rebuild((b) => b
      ..status = LoginStatusEnum.done
      ..user.replace(action.user));

LoginState _loginUsingGoogleFailedReducer(
        LoginState state, LoginUsingGoogleFailed action) =>
    state.rebuild((b) => b
      ..status = LoginStatusEnum.done
      ..exception = action.exception);
