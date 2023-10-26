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
    return FirebaseAuth.instance.signOut();
  }

  Future<void> deleteAccount() {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return user.delete();
    } else {
      throw FirebaseAuthException(message: 'User is null', code: '');
    }
  }
}
