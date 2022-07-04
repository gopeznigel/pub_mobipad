import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final AuthService _apiService = AuthService._internal();

  factory AuthService() => _apiService;

  AuthService._internal() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() {
    var user = _firebaseAuth.currentUser;
    return user;
  }

  Future<User?> signIn(String email, String password) async {
    var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<User?> signInWithGoogle(AuthCredential cred) async {
    var result = await _firebaseAuth.signInWithCredential(cred);
    return result.user;
  }

  Future<User?> signUp(String email, String password) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<void> addUser(Map<String, dynamic> data, String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(data);
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
