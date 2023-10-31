import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/usecases/auth_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class SignUpViewModel extends StateNotifier<AsyncValue<void>> {
  SignUpViewModel(
    this._navigationService,
    this._authUseCases,
  ) : super(const AsyncValue.data(null));

  final NavigationService _navigationService;
  final AuthUseCase _authUseCases;

  void navigateToLogin() => _navigationService.navigateToLogin();
  void navigateToHome() => _navigationService.navigateToHome();

  Future<void> signUp(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    try {
      await _authUseCases.signUp(email, password);
      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(e, e.stackTrace!);
    }
  }

  Future<void> googleSignIn() async {}
  Future<void> facebookSignIn() async {}
}
