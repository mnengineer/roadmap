import 'package:firebase_auth/firebase_auth.dart';
import 'package:roadmap/core/exceptions/custom_exception.dart';

class AuthDatasource {
  AuthDatasource(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  Future<UserCredential> login(String email, String password) async {
    try {
      return _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
      return _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  Future<void> logout() async {
    try {
      return _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  Future<void> deleteAccount() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        return user.delete();
      } on FirebaseAuthException catch (e) {
        throw AuthException(e.message);
      }
    } else {
      throw AuthException('No user currently signed in');
    }
  }
}
