import 'package:roadmap/application/interfaces/logger.dart';
import 'package:roadmap/application/state/auth_state_notifier.dart';

/// ログインのユースケース
class LoginUsecase {
  LoginUsecase({
    required this.logger,
    required this.authStateNotifier,
  });
  final Logger logger;
  final AuthStateNotifier authStateNotifier;

  /// メールアドレスとパスワードでログイン処理
  Future<void> login(String email, String password) async {
    logger.debug('LoginUsecase.login()');
    await authStateNotifier.loginWithEmailAndPassword(email, password);
  }
}
