import 'package:redux/redux.dart';

import '../../exception/action_exception.dart';
import '../../state.dart';
import 'actions.dart';
import 'api.dart';

List<Middleware<AppState>> getMiddleware(ForgotPasswordApi forgotPasswordApi) =>
    [
      ApiIntegration(forgotPasswordApi).getMiddlewareBindings(),
    ].expand((x) => x).toList();

class ApiIntegration {
  const ApiIntegration(this.api);

  final ForgotPasswordApi api;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, SendResetPasswordLink>(
            _handleSendResetPasswordLink),
      ];

  void _handleSendResetPasswordLink(Store<AppState> store,
      SendResetPasswordLink action, NextDispatcher next) {
    Future<void> _login(
        Store<AppState> store, SendResetPasswordLink action) async {
      try {
        await api.sendResetPasswordLink(action.email);
        store.dispatch(SendResetPasswordLinkSucceeded());
      } on Exception catch (exception) {
        store.dispatch(
            SendResetPasswordLinkFailed(ActionException(exception, action)));
      }
    }

    _login(store, action);
    next(action);
  }
}
