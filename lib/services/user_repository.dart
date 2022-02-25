import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<SharedPreferences> get _localStorage => SharedPreferences.getInstance();
  
  Future<void> deleteUserId() async => (await _localStorage).remove('userId');

  Future<void> persistuserId(String userId) async => (await _localStorage).setString('userId', userId);

  Future<bool> hasuserId() async => (await _localStorage).containsKey('userId');
}