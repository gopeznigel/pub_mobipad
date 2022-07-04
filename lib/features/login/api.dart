import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobipad/features/login/dtos.dart';
import 'package:mobipad/features/login/serializers.dart' as user_serializer;
import 'package:mobipad/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginApi {
  LoginApi(this._api);

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final AuthService _api;

  UserDto? getUser() {
    final user = _api.getCurrentUser();

    if (user != null) {
      return _firebaseUserToUserDto(user);
    } else {
      return null;
    }
  }

  Future<UserDto?> signIn(String email, String password) async {
    var user = await _api.signIn(email, password);

    if (user != null) {
      return _firebaseUserToUserDto(user);
    } else {
      return null;
    }
  }

  Future<UserDto?> signInUsingGoogle() async {
    try {
      var googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        var googleAuth = await googleUser.authentication;

        var credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        var user = await _api.signInWithGoogle(credential);

        if (user != null) {
          var userDto = _firebaseUserToUserDto(user);

          // Add user to firebase
          await _addUser(userDto);

          return userDto;
        } else {
          return null;
        }
      }
    } catch (error) {
      throw Exception(error.toString());
    }

    throw Exception('Sign In failed.');
  }

  Future<UserDto?> signUp(String email, String password) async {
    var user = await _api.signUp(email, password);

    if (user != null) {
      var userDto = _firebaseUserToUserDto(user);

      // Add user to firebase
      await _addUser(userDto);

      return userDto;
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _api.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      return;
    }
  }

  UserDto _firebaseUserToUserDto(User user) {
    return UserDto(
      (b) => b
        ..email = user.email
        ..userId = user.uid,
    );
  }

  Future<void> _addUser(UserDto user) async => await _api.addUser(
      user_serializer.serializers.serializeWith(UserDto.serializer, user)
          as Map<String, dynamic>,
      user.userId);
}
