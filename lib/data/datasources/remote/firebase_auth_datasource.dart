import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    if (uid == null) {
      throw FirebaseAuthException(
        message: 'No user is currently signed in',
        code: 'no-current-user',
      );
    }
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    await user?.delete();
    await FirebaseAuth.instance.signOut();
  }
}
