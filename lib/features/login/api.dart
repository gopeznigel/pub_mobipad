import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../services/auth_api.dart';
import '../../services/user_repository.dart';
import 'model.dart';

class LoginApi {
  LoginApi(this._userRepository, this._api)
      : assert(_userRepository != null && _api != null);

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final UserRepository _userRepository;
  final Auth _api;

  Future<bool> hasUserId() async {
    return await _userRepository.hasuserId();
  }

  Future<OhNotesUser> getUser() async {
    var firebaseUser = await _api.getCurrentUser();
    await _userRepository.persistuserId(firebaseUser.uid);
    return OhNotesUser.fromJson(
        firebaseUserToMap(firebaseUser), firebaseUser.uid);
  }

  Future<OhNotesUser> signIn(String email, String password) async {
    var firebaseUser = await _api.signIn(email, password);
    await _userRepository.persistuserId(firebaseUser.uid);
    return OhNotesUser.fromJson(
        firebaseUserToMap(firebaseUser), firebaseUser.uid);
  }

  Future<OhNotesUser> signUp(String email, String password) async {
    var firebaseUser = await _api.signUp(email, password);
    await _userRepository.persistuserId(firebaseUser.uid);

    // Add user to database
    await _api.addUser(firebaseUserToMap(firebaseUser), firebaseUser.uid);

    return OhNotesUser.fromJson(
        firebaseUserToMap(firebaseUser), firebaseUser.uid);
  }

  Future<void> signOut() async {
    await _api.signOut();
    await _userRepository.deleteUserId();
  }

  Map<String, dynamic> firebaseUserToMap(User user) {
    return <String, dynamic>{
      'userId': user.uid,
      'email': user.email,
    };
  }

  Future<OhNotesUser> signInUsingGoogle() async {
    try {
      var googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        var googleAuth = await googleUser.authentication;

        var credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        var firebaseUser = await _api.signInWithGoogle(credential);

        await _userRepository.persistuserId(firebaseUser.uid);

        // Add user to database
        await _api.addUser(firebaseUserToMap(firebaseUser), firebaseUser.uid);

        return OhNotesUser.fromJson(
            firebaseUserToMap(firebaseUser), firebaseUser.uid);
      }
    } catch (error) {
      return null;
    }

    return null;
  }
}
