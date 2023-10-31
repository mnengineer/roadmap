import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/usecases/auth_usecase.dart';

class SettingViewModel extends StateNotifier<AsyncValue<void>> {
  SettingViewModel(this._authUseCases) : super(const AsyncValue.data(null));

  final AuthUseCase _authUseCases;
  bool shouldCloseBottomSheet = false;

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await _authUseCases.logout();
      shouldCloseBottomSheet = true;
      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (e) {
      shouldCloseBottomSheet = false;
      state = AsyncValue.error(e, e.stackTrace!);
    }
  }

  Future<void> deleteAccount() async {
    state = const AsyncValue.loading();
    try {
      await _authUseCases.deleteAccount();
      shouldCloseBottomSheet = true;
      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (e) {
      shouldCloseBottomSheet = false;
      state = AsyncValue.error(e, e.stackTrace!);
    }
  }
}
