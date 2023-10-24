import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/usecases/auth_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class SignUpViewModel extends StateNotifier<SignUpState> {
  SignUpViewModel(this._navigationService, this._authUseCases)
      : super(SignUpState.initial());
  final NavigationService _navigationService;

  final AuthUseCase _authUseCases;

  void navigateToLogin() => _navigationService.navigateToLogin();
  void navigateToHome() => _navigationService.navigateToHome();

  void toggleShowPassword() {
    state = SignUpState(
      user: state.user,
      isLoading: state.isLoading,
      showPassword: !state.showPassword,
    );
  }

  Future<void> signUp(String email, String password) async {
    try {
      // 新規登録
      final user = await _authUseCases.signUp(email, password);
      // 認証が成功した場合、新しい状態をセット
      state = SignUpState.authenticated(user);
      // ホーム画面へ遷移
      navigateToHome();
    } on FirebaseAuthException catch (e) {
      // エラーハンドリング（例: エラーメッセージの表示）
      print(e.message);
      state = SignUpState(); // エラーが発生した場合、初期状態に戻す
    }
  }

  Future<void> googleSignIn() async {
    state = SignUpState(isGoogleLoading: true);
    // ロジック実装
    state = SignUpState();
  }

  Future<void> facebookSignIn() async {
    state = SignUpState(isFacebookLoading: true);
    // ロジック実装
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

  factory SignUpState.loading() => SignUpState(isLoading: true);
  factory SignUpState.authenticated(User user) => SignUpState(user: user);
  factory SignUpState.initial() => SignUpState();

  final User? user;
  final bool isLoading;
  final bool showPassword;
  final bool isGoogleLoading;
  final bool isFacebookLoading;
}
