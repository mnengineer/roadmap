import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class SignUpViewmodel extends StateNotifier<SignUpState> {
  SignUpViewmodel(this._navigationService)
      : super(
          SignUpState(
            showPassword: false,
            isGoogleLoading: false,
            isFacebookLoading: false,
            isLoading: false,
            email: TextEditingController(),
            password: TextEditingController(),
            fullName: TextEditingController(),
            phoneNo: TextEditingController(),
          ),
        );
  final NavigationService _navigationService;

  GlobalKey<FormState> get signupFormKey => GlobalKey<FormState>();

  void navigateToLogin() => _navigationService.navigateToLogin();
  void navigateToHome() => _navigationService.navigateToHome();

  Future<void> createUser() async {
    // ロジック実装
    navigateToHome();
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    // ロジック実装
  }
}

class SignUpState {
  SignUpState({
    required this.showPassword,
    required this.isGoogleLoading,
    required this.isFacebookLoading,
    required this.isLoading,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNo,
  });
  final bool showPassword;
  final bool isGoogleLoading;
  final bool isFacebookLoading;
  final bool isLoading;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController fullName;
  final TextEditingController phoneNo;
}
