import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 認証状態を管理するNotifier
class AuthStateNotifier extends StateNotifier<User?> {
  AuthStateNotifier(this._firebaseAuth) : super(null) {
    _firebaseAuth.authStateChanges().listen((user) {
      state = user;
    });
  }
  final FirebaseAuth _firebaseAuth;

  User? get user => state;

  // ログイン
  Future<void> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // 新規登録
  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // ログアウト
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
