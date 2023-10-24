import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/usecases/auth_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel(this._navigationService, this._authUseCases)
      : super(LoginState());
  final NavigationService _navigationService;

  final AuthUseCase _authUseCases;

  void navigateToSignup() => _navigationService.navigateToSignup();
  void navigateToHome() => _navigationService.navigateToHome();

  void toggleShowPassword() {
    state = LoginState(
      isLoading: state.isLoading,
      showPassword: !state.showPassword,
    );
  }

  Future<void> login(String email, String password) async {
    try {
      state = LoginState(isLoading: true);
      await _authUseCases.login(email, password);
      state = LoginState();
      navigateToHome();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      state = LoginState();
    }
  }

  Future<void> googleSignIn() async {
    state = LoginState(isGoogleLoading: true);
    // ロジック実装
    state = LoginState();
  }

  Future<void> facebookSignIn() async {
    state = LoginState(isFacebookLoading: true);
    // ロジック実装
    state = LoginState();
  }
}

class LoginState {
  LoginState({
    this.isLoading = false,
    this.showPassword = false,
    this.isGoogleLoading = false,
    this.isFacebookLoading = false,
  });

  final bool isLoading;
  final bool showPassword;
  final bool isGoogleLoading;
  final bool isFacebookLoading;
}
