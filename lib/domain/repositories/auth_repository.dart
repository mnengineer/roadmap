import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> signUp(String email, String password);
}
