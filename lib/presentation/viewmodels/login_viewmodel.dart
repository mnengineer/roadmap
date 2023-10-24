import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/usecases/auth_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class LoginViewModel extends StateNotifier<AuthState> {
  LoginViewModel(this._navigationService, this._authUseCases)
      : super(AuthState.initial());
  final NavigationService _navigationService;

  final AuthUseCase _authUseCases;

  void navigateToSignup() => _navigationService.navigateToSignup();
  void navigateToHome() => _navigationService.navigateToHome();

  void toggleShowPassword() {
    state = AuthState(
      user: state.user,
      isLoading: state.isLoading,
      showPassword: !state.showPassword,
    );
  }

  Future<void> login(String email, String password) async {
    try {
      // ログイン
      final user = await _authUseCases.login(email, password);
      // 認証が成功した場合、新しい状態をセット
      state = AuthState.authenticated(user);
      // ホーム画面へ遷移
      navigateToHome();
    } on FirebaseAuthException catch (e) {
      // エラーハンドリング（例: エラーメッセージの表示）
      print(e.message);
      state = AuthState(); // エラーが発生した場合、初期状態に戻す
    }
  }

  Future<void> googleSignIn() async {
    state = AuthState(isGoogleLoading: true);
    // ロジック実装
    state = AuthState();
  }

  Future<void> facebookSignIn() async {
    state = AuthState(isFacebookLoading: true);
    // ロジック実装
    state = AuthState();
  }
}

class AuthState {
  AuthState({
    this.user,
    this.isLoading = false,
    this.showPassword = false,
    this.isGoogleLoading = false,
    this.isFacebookLoading = false,
  });

  factory AuthState.loading() => AuthState(isLoading: true);
  factory AuthState.authenticated(User user) => AuthState(user: user);
  factory AuthState.initial() => AuthState();

  final User? user;
  final bool isLoading;
  final bool showPassword;
  final bool isGoogleLoading;
  final bool isFacebookLoading;
}
