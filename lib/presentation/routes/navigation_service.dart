import 'package:go_router/go_router.dart';
import 'package:roadmap/core/constants/routes.dart';

class NavigationService {
  NavigationService(this.router);

  final GoRouter router;

  void navigatePop() {
    router.pop();
  }

  void navigateTo(String path, {Object? extra, bool isPush = false}) {
    if (isPush) {
      router.push(path, extra: extra);
    } else {
      router.go(path, extra: extra);
    }
  }

  void navigateToOnBoarding() => navigateTo(Routes.onboarding);
  void navigateToWelcome() => navigateTo(Routes.welcome);
  void navigateToLogin() => navigateTo(Routes.login);
  void navigateToSignup() => navigateTo(Routes.signup);
  void navigateToHome() => navigateTo(Routes.home);
  void navigateToAdd() => navigateTo(Routes.add, isPush: true);
  void navigateToEdit(Object extra) =>
      navigateTo(Routes.edit, extra: extra, isPush: true);
  void navigateToDetail(Object extra) =>
      navigateTo(Routes.detail, extra: extra, isPush: true);
}
