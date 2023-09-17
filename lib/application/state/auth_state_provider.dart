import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/application/state/auth_state_notifier.dart';

// 認証状態のProvider
final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, User?>((ref) {
  return AuthStateNotifier(FirebaseAuth.instance);
});
