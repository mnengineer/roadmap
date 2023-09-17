import 'package:roadmap/application/interfaces/logger.dart';
import 'package:roadmap/application/state/auth_state_notifier.dart';

/// ログアウトのユースケース
class LogoutUsecase {
  LogoutUsecase({
    required this.logger,
    required this.authStateNotifier,
  });
  final Logger logger;
  final AuthStateNotifier authStateNotifier;

  /// ログアウト処理
  Future<void> logout() async {
    logger.debug('LogoutUsecase.logout()');
    await authStateNotifier.logout();
  }
}
