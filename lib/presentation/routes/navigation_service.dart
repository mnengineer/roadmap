import 'package:go_router/go_router.dart';

class NavigationService {
  NavigationService(this.router);

  final GoRouter router;

  void navigateToHome() {
    router.go('/home');
  }
}
