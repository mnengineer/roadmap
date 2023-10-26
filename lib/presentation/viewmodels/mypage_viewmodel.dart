import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:roadmap/domain/usecases/auth_usecase.dart';

class MypageViewmodel extends StateNotifier<MypageState> {
  MypageViewmodel(this._authUseCases) : super(MypageState());
  final AuthUseCase _authUseCases;

  Future<void> logout() async {
    try {
      state = MypageState(isLoading: true);
      await _authUseCases.logout();
      state = MypageState();
    } on FirebaseAuthException catch (e) {
      // TODO(masashi): エラー時の処理実装
      Logger().e(e);
      state = MypageState();
    }
  }

  Future<void> deleteAccount() async {
    try {
      state = MypageState(isLoading: true);
      await _authUseCases.deleteAccount();
      state = MypageState();
    } on FirebaseAuthException catch (e) {
      // TODO(masashi): エラー時の処理実装
      Logger().e(e);
      state = MypageState();
    }
  }
}

class MypageState {
  MypageState({
    this.isLoading = false,
  });

  final bool isLoading;
}
