import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class WelcomeViewModel extends StateNotifier<WelcomeState> {
  WelcomeViewModel(this._navigationService) : super(WelcomeState());

  final NavigationService _navigationService;

  void navigateToLogin() => _navigationService.navigateToLogin();
  void navigateToSignup() => _navigationService.navigateToSignup();

  Future<void> animationIn() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(animate: true);
  }
}

class WelcomeState {
  WelcomeState({this.animate = false});
  final bool animate;

  WelcomeState copyWith({
    bool? animate,
  }) {
    return WelcomeState(
      animate: animate ?? this.animate,
    );
  }
}
