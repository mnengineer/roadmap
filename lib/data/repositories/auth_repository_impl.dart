import 'package:firebase_auth/firebase_auth.dart';
import 'package:roadmap/data/datasources/remote/firebase/auth_datasource.dart';
import 'package:roadmap/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authDatasource);
  final AuthDatasource _authDatasource;

  @override
  Future<User> login(String email, String password) async {
    final userCredential = await _authDatasource.login(email, password);
    return userCredential.user!;
  }

  @override
  Future<User> signUp(String email, String password) async {
    final userCredential = await _authDatasource.signUp(email, password);
    return userCredential.user!;
  }

  @override
  Future<void> logout() async {
    await _authDatasource.logout();
  }

  @override
  Future<void> deleteAccount() async {
    await _authDatasource.deleteAccount();
  }
}
