import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/application/di/usecases.dart';
import 'package:roadmap/application/state/auth_state_provider.dart';
import 'package:roadmap/presentation/screens/list.dart';

// 認証画面
class AuthScreen extends HookConsumerWidget {
  AuthScreen({super.key});

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    if (authState != null) {
      return const ListScreen();
    }

    final isLogin = useState(true);
    final isAuthenticating = useState(false);
    final enteredEmail = useState('');
    final enteredPassword = useState('');

    Future<void> submit(
      BuildContext context,
      ValueNotifier<bool> isLogin,
      ValueNotifier<bool> isAuthenticating,
      String enteredEmail,
      String enteredPassword,
    ) async {
      _form.currentState!.save();

      try {
        isAuthenticating.value = true;
        if (isLogin.value) {
          // ログインユースケース呼び出す
          await ref.read(loginProvider).login(
                enteredEmail,
                enteredPassword,
              );
        } else {
          // サインアップユースケース呼び出す
          await ref.read(signUpProvider).signUp(
                enteredEmail,
                enteredPassword,
              );
        }
      } on FirebaseAuthException catch (error) {
        if (error.message != null) {}
      } finally {
        isAuthenticating.value = false;
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              enteredEmail.value = value!;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              enteredPassword.value = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          if (isAuthenticating.value)
                            const CircularProgressIndicator(),
                          if (!isAuthenticating.value)
                            ElevatedButton(
                              onPressed: () => submit(
                                context,
                                isLogin,
                                isAuthenticating,
                                enteredEmail.value,
                                enteredPassword.value,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(isLogin.value ? 'Login' : 'Signup'),
                            ),
                          if (!isAuthenticating.value)
                            TextButton(
                              onPressed: () {
                                isLogin.value = !isLogin.value;
                              },
                              child: Text(
                                isLogin.value
                                    ? 'Create an account'
                                    : 'I already have an account.',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
