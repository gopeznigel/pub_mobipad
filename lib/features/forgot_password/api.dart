import 'package:mobipad/services/auth_service.dart';

class ForgotPasswordApi {
  final AuthService _auth;

  ForgotPasswordApi(this._auth);

  Future<void> sendResetPasswordLink(String email) async {
    await _auth.resetPassword(email);
  }
}
