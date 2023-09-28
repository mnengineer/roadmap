import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/presentation/routes/go_router.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, SplashState>((ref) {
  final goRouter = ref.read(goRouterProvider);
  return SplashViewModel(goRouter);
});

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel(this.goRouter) : super(SplashState());
  final GoRouter goRouter;

  void navigateToHome() {
    goRouter.go('/home');
  }

  Future<void> startAnimation() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(animate: true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    navigateToHome();
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
