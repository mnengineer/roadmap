import 'package:roadmap/presentation/routes/navigation_service.dart';

class WelcomeViewModel {
  WelcomeViewModel(this._navigationService);

  final NavigationService _navigationService;

  void navigateToLogin() => _navigationService.navigateToLogin();
  void navigateToSignup() => _navigationService.navigateToSignup();
}
