import 'package:mobipad/services/auth_api.dart';

class ForgotPasswordApi {
  ForgotPasswordApi(this._api) : assert(_api != null);

  final Auth _api;

  Future<void> sendResetPasswordLink(String email) async {
    await _api.resetPassword(email);
  }
}
