import 'package:roadmap/application/interfaces/logger.dart';
import 'package:roadmap/application/state/auth_state_notifier.dart';

/// 新規登録のユースケース
class SignUpUsecase {
  SignUpUsecase({
    required this.logger,
    required this.authStateNotifier,
  });
  final Logger logger;
  final AuthStateNotifier authStateNotifier;

  /// メールアドレスとパスワードで新規登録処理
  Future<void> signUp(String email, String password) async {
    logger.debug('SignupUsecase.signUp()');
    await authStateNotifier.registerWithEmailAndPassword(email, password);
  }
}
