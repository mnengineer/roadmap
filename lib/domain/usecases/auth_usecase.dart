import 'package:firebase_auth/firebase_auth.dart';
import 'package:roadmap/domain/repositories/auth_repository.dart';

class AuthUseCase {
  AuthUseCase(this.authRepository);
  final AuthRepository authRepository;

  Future<User> login(String email, String password) {
    return authRepository.login(email, password);
  }

  Future<User> signUp(String email, String password) {
    return authRepository.signUp(email, password);
  }

  Future<void> logout() {
    return authRepository.logout();
  }

  Future<void> deleteAccount() {
    return authRepository.deleteAccount();
  }
}
