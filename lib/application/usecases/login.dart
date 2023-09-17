import 'package:roadmap/application/interfaces/logger.dart';
import 'package:roadmap/application/state/auth_state_notifier.dart';

/// ログイン
class LoginUsecase {
  LoginUsecase({
    required this.logger,
    required this.authStateNotifier,
  });
  final Logger logger;
  final AuthStateNotifier authStateNotifier;

  /// ログインする
  Future<void> login(String email, String password) async {
    logger.debug('LoginUsecase.login()');

    // ログイン処理
    await authStateNotifier.loginWithEmailAndPassword(email, password);
  }
}
