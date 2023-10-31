import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:roadmap/domain/usecases/auth_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class SignUpViewModel extends StateNotifier<SignUpState> {
  SignUpViewModel(this._navigationService, this._authUseCases)
      : super(SignUpState());

  final NavigationService _navigationService;
  final AuthUseCase _authUseCases;

  void navigateToLogin() => _navigationService.navigateToLogin();
  void navigateToHome() => _navigationService.navigateToHome();

  void toggleShowPassword() {
    state = SignUpState(
      isLoading: state.isLoading,
      showPassword: !state.showPassword,
    );
  }

  Future<void> signUp(String email, String password) async {
    try {
      state = SignUpState(isLoading: true);
      await _authUseCases.signUp(email, password);
      state = SignUpState();
      navigateToHome();
    } on FirebaseAuthException catch (e) {
      // TODO(masashi): エラー時の処理実装
      Logger().e(e);
      state = SignUpState();
    }
  }

  Future<void> googleSignIn() async {
    state = SignUpState(isGoogleLoading: true);
    // TODO(masashi): Googleログインの実装
    state = SignUpState();
  }

  Future<void> facebookSignIn() async {
    state = SignUpState(isFacebookLoading: true);
    // TODO(masashi): Facebookログインの実装
    state = SignUpState();
  }
}

class SignUpState {
  SignUpState({
    this.user,
    this.isLoading = false,
    this.showPassword = false,
    this.isGoogleLoading = false,
    this.isFacebookLoading = false,
  });

  final User? user;
  final bool isLoading;
  final bool showPassword;
  final bool isGoogleLoading;
  final bool isFacebookLoading;
}
