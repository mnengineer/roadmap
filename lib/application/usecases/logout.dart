import 'package:roadmap/application/interfaces/logger.dart';
import 'package:roadmap/application/state/auth_state_notifier.dart';

/// ログアウト
class LogoutUsecase {
  LogoutUsecase({
    required this.logger,
    required this.authStateNotifier,
  });
  final Logger logger;
  final AuthStateNotifier authStateNotifier;

  /// ログアウトする
  Future<void> logout() async {
    logger.debug('LogoutUsecase.logout()');

    // ログアウトの状態に変更
    await authStateNotifier.logout();
  }
}
