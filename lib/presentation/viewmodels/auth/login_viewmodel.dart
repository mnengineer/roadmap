import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/usecases/auth_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class LoginViewModel extends StateNotifier<AsyncValue<void>> {
  LoginViewModel(
    this._navigationService,
    this._authUseCases,
  ) : super(const AsyncValue.data(null));

  final NavigationService _navigationService;
  final AuthUseCase _authUseCases;

  void navigateToSignup() => _navigationService.navigateToSignup();
  void navigateToHome() => _navigationService.navigateToHome();

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    try {
      await _authUseCases.login(email, password);
      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(e, e.stackTrace!);
    }
  }

  Future<void> googleSignIn() async {}

  Future<void> facebookSignIn() async {}
}
