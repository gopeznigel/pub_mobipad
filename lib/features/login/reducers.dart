import 'package:redux/redux.dart';

import 'actions.dart';
import 'state.dart';

final Reducer<LoginState> loginStateReducer = combineReducers([
  TypedReducer<LoginState, StoreUser>(_storeUserReducer),
  TypedReducer<LoginState, ClearUser>(_clearUserReducer),
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
  TypedReducer<LoginState, Logout>(_logoutReducer),
  TypedReducer<LoginState, AccountInitDone>(_accountInitDoneReducer),
]);

LoginState _accountInitDoneReducer(LoginState state, AccountInitDone action) =>
    state
      ..newLogin = false
      ..exception = null;

LoginState _storeUserReducer(LoginState state, StoreUser action) => state
  ..user = action.user
  ..isLoading = false
  ..exception = null;

LoginState _clearUserReducer(LoginState state, ClearUser action) =>
    state..user = null;

LoginState _loginReducer(LoginState state, Login action) => state
  ..newLogin = true
  ..isLoading = true
  ..exception = null;

LoginState _loginSucceededReducer(LoginState state, LoginSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

LoginState _loginFailedReducer(LoginState state, LoginFailed action) => state
  ..isLoading = false
  ..exception = action.exception;

LoginState _signUpReducer(LoginState state, SignUp action) => state
  ..newLogin = true
  ..isLoading = true
  ..exception = null;

LoginState _signUpSucceededReducer(LoginState state, SignUpSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

LoginState _signUpFailedReducer(LoginState state, SignUpFailed action) => state
  ..isLoading = false
  ..exception = action.exception;

LoginState _loginUsingGoogleReducer(
        LoginState state, LoginUsingGoogle action) =>
    state
      ..newLogin = true
      ..googleSignIn = true
      ..isLoading = true
      ..exception = null;

LoginState _loginUsingGoogleSucceededReducer(
        LoginState state, LoginUsingGoogleSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

LoginState _loginUsingGoogleFailedReducer(
        LoginState state, LoginUsingGoogleFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

LoginState _logoutReducer(LoginState state, Logout action) => state
  ..googleSignIn = false
  ..exception = null;
