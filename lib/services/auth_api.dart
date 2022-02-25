import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final Auth _apiService = Auth._internal();

  factory Auth() => _apiService;

  Auth._internal() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async {
    var user = _firebaseAuth.currentUser;
    return user;
  }

  Future<User> signIn(String email, String password) async {
    var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<User> signInWithGoogle(AuthCredential cred) async {
    var result = await _firebaseAuth.signInWithCredential(cred);
    return result.user;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<User> signUp(String email, String password) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<void> addUser(Map data, String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(data);
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
