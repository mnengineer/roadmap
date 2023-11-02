import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/usecases/auth_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class SettingViewModel extends StateNotifier<AsyncValue<void>> {
  SettingViewModel(this._navigationService, this._authUseCases)
      : super(const AsyncValue.data(null));

  final NavigationService _navigationService;
  final AuthUseCase _authUseCases;

  void navigatePop() => _navigationService.navigatePop();
  void navigateToWelcome() => _navigationService.navigateToWelcome();

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await _authUseCases.logout();
      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(e, e.stackTrace ?? StackTrace.empty);
    }
  }

  Future<void> deleteAccount() async {
    state = const AsyncValue.loading();
    try {
      await _authUseCases.deleteAccount();
      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(e, e.stackTrace ?? StackTrace.empty);
    }
  }
}
