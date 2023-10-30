import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class WelcomeViewModel extends StateNotifier<Welcometate> {
  WelcomeViewModel(this._navigationService) : super(Welcometate());

  final NavigationService _navigationService;

  void navigateToLogin() => _navigationService.navigateToLogin();
  void navigateToSignup() => _navigationService.navigateToSignup();

  Future<void> animationIn() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(animate: true);
  }
}

class Welcometate {
  Welcometate({this.animate = false});
  final bool animate;

  Welcometate copyWith({
    bool? animate,
  }) {
    return Welcometate(
      animate: animate ?? this.animate,
    );
  }
}
