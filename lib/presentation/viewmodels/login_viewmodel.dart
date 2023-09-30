import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel(this._navigationService)
      : super(
          LoginState(
            showPassword: false,
            isLoading: false,
            isGoogleLoading: false,
            isFacebookLoading: false,
            email: TextEditingController(),
            password: TextEditingController(),
            loginFormKey: GlobalKey<FormState>(),
          ),
        );
  final NavigationService _navigationService;

  void navigateToSignup() => _navigationService.navigateToSignup();
  void navigateToHome() => _navigationService.navigateToHome();

  Future<void> toggleShowPassword() async {
    state = LoginState(
      showPassword: !state.showPassword,
      isLoading: state.isLoading,
      isGoogleLoading: state.isGoogleLoading,
      isFacebookLoading: state.isFacebookLoading,
      email: state.email,
      password: state.password,
      loginFormKey: state.loginFormKey,
    );
  }

  Future<void> login() async {
    // ロジック実装
    navigateToHome();
  }

  Future<void> googleSignIn() async {
    // ロジック実装
  }

  Future<void> facebookSignIn() async {
    // ロジック実装
  }
}

class LoginState {
  LoginState({
    required this.showPassword,
    required this.isLoading,
    required this.isGoogleLoading,
    required this.isFacebookLoading,
    required this.email,
    required this.password,
    required this.loginFormKey,
  });
  final bool showPassword;
  final bool isLoading;
  final bool isGoogleLoading;
  final bool isFacebookLoading;
  final TextEditingController email;
  final TextEditingController password;
  final GlobalKey<FormState> loginFormKey;
}
