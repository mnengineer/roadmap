import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel(this._navigationService) : super(SplashState());
  final NavigationService _navigationService;

  void navigateToOnBoarding() {
    _navigationService.navigateToWelcome();
  }

  Future<void> startAnimation() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(animate: true);
    await Future<void>.delayed(const Duration(milliseconds: 3000));
    state = state.copyWith(animate: false);
    await Future<void>.delayed(const Duration(milliseconds: 1800));
    navigateToOnBoarding();
  }
}

class SplashState {
  SplashState({this.animate = false});
  final bool animate;

  SplashState copyWith({
    bool? animate,
  }) {
    return SplashState(
      animate: animate ?? this.animate,
    );
  }
}
