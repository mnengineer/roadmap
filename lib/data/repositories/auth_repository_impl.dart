import 'package:firebase_auth/firebase_auth.dart';
import 'package:roadmap/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:roadmap/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._firebaseAuthDatasource);
  final FirebaseAuthDatasource _firebaseAuthDatasource;

  @override
  Future<User> login(String email, String password) async {
    final userCredential = await _firebaseAuthDatasource.login(email, password);
    final user = userCredential.user;
    if (user != null) {
      return user;
    } else {
      throw FirebaseAuthException(message: 'User is null', code: '');
    }
  }

  @override
  Future<User> signUp(String email, String password) async {
    final userCredential =
        await _firebaseAuthDatasource.signUp(email, password);
    final user = userCredential.user;
    if (user != null) {
      return user;
    } else {
      throw FirebaseAuthException(message: 'User is null', code: '');
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuthDatasource.logout();
  }

  @override
  Future<void> deleteAccount() async {
    await _firebaseAuthDatasource.deleteAccount();
  }
}
