import 'package:redux/redux.dart';

import 'actions.dart';
import 'state.dart';

final Reducer<ForgotPasswordState> forgotPasswordStateReducer =
    combineReducers([
  TypedReducer<ForgotPasswordState, SendResetPasswordLink>(
      _sendResetPasswordLinkReducer),
  TypedReducer<ForgotPasswordState, SendResetPasswordLinkSucceeded>(
      _sendResetPasswordLinkSucceededReducer),
  TypedReducer<ForgotPasswordState, SendResetPasswordLinkFailed>(
      _sendResetPasswordLinkFailedReducer),
]);

ForgotPasswordState _sendResetPasswordLinkReducer(
        ForgotPasswordState state, SendResetPasswordLink action) =>
    state.rebuild((b) => b
      ..isBusy = true
      ..exception = null);

ForgotPasswordState _sendResetPasswordLinkSucceededReducer(
        ForgotPasswordState state, SendResetPasswordLinkSucceeded action) =>
    state.rebuild((b) => b..isBusy = false);

ForgotPasswordState _sendResetPasswordLinkFailedReducer(
        ForgotPasswordState state, SendResetPasswordLinkFailed action) =>
    state.rebuild((b) => b
      ..isBusy = false
      ..exception = action.exception);
