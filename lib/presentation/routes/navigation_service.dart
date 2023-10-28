import 'package:go_router/go_router.dart';
import 'package:roadmap/domain/entities/item.dart';

class NavigationService {
  NavigationService(this.router);

  final GoRouter router;

  void navigateToOnBoarding() {
    router.go('/onboarding');
  }

  void navigateToWelcome() {
    router.go('/welcome');
  }

  void navigateToLogin() {
    router.go('/login');
  }

  void navigateToSignup() {
    router.go('/signup');
  }

  void navigateToHome() {
    router.go('/home');
  }

  void navigateToDetail(Item item) {
    router.push('/detail', extra: item);
  }
}
