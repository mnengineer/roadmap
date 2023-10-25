import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDatasource {
  FirebaseAuthDatasource(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  Future<UserCredential> login(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() {
    return _firebaseAuth.signOut();
  }

  Future<void>? deleteAccount() {
    return _firebaseAuth.currentUser?.delete();
  }
}
