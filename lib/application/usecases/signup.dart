import 'package:roadmap/application/interfaces/logger.dart';
import 'package:roadmap/application/state/auth_state_notifier.dart';

/// 新規登録
class SignUpUsecase {
  SignUpUsecase({
    required this.logger,
    required this.authStateNotifier,
  });
  final Logger logger;
  final AuthStateNotifier authStateNotifier;

  /// 新規登録する
  Future<void> signUp(String email, String password) async {
    logger.debug('SignupUsecase.signUp()');

    // 新規登録処理
    await authStateNotifier.registerWithEmailAndPassword(email, password);
  }
}
