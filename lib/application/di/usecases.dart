import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/application/di/infrastructure.dart';
import 'package:roadmap/application/state/auth_state_provider.dart';
import 'package:roadmap/application/state/editting_memo_provider.dart';
import 'package:roadmap/application/state/memo_list_provider.dart';
import 'package:roadmap/application/usecases/add_memo.dart';
import 'package:roadmap/application/usecases/delete_memo.dart';
import 'package:roadmap/application/usecases/init_app.dart';
import 'package:roadmap/application/usecases/login.dart';
import 'package:roadmap/application/usecases/logout.dart';
import 'package:roadmap/application/usecases/signup.dart';
import 'package:roadmap/application/usecases/update_memo.dart';

/// Init App
final initAppProvider = Provider<InitAppUsecase>(
  (ref) {
    final logger = ref.read(loggerProvider);
    final firebase = ref.watch(firebaseProvider);
    final listNotifier = ref.watch(memoListProvider.notifier);
    return InitAppUsecase(
      logger: logger,
      firebase: firebase,
      listNotifier: listNotifier,
    );
  },
);

/// Add Memo
final addMemoProvider = Provider<AddMemoUsecase>(
  (ref) {
    final logger = ref.read(loggerProvider);
    final firebase = ref.watch(firebaseProvider);
    final listNotifier = ref.watch(memoListProvider.notifier);
    return AddMemoUsecase(
      logger: logger,
      firebase: firebase,
      listNotifier: listNotifier,
    );
  },
);

/// Delete Memo
final deleteMemoProvider = Provider<DeleteMemoUsecase>(
  (ref) {
    final logger = ref.read(loggerProvider);
    final firebase = ref.watch(firebaseProvider);
    final listNotifier = ref.watch(memoListProvider.notifier);
    return DeleteMemoUsecase(
      logger: logger,
      firebase: firebase,
      listNotifier: listNotifier,
    );
  },
);

/// Update Memo
final updateMemoProvider = Provider.family<UpdateMemoUsecase, String>(
  (ref, id) {
    final logger = ref.read(loggerProvider);
    final firebase = ref.watch(firebaseProvider);
    final listNotifier = ref.watch(memoListProvider.notifier);
    final edittingNotifier = ref.watch(edittingMemoProvider(id).notifier);
    return UpdateMemoUsecase(
      logger: logger,
      firebase: firebase,
      listNotifier: listNotifier,
      edittingNotifier: edittingNotifier,
    );
  },
);

/// Login
final loginProvider = Provider<LoginUsecase>(
  (ref) {
    final logger = ref.read(loggerProvider);
    final authStateNotifier = ref.watch(authStateProvider.notifier);
    return LoginUsecase(
      logger: logger,
      authStateNotifier: authStateNotifier,
    );
  },
);

/// Signup
final signUpProvider = Provider<SignUpUsecase>(
  (ref) {
    final logger = ref.read(loggerProvider);
    final authStateNotifier = ref.watch(authStateProvider.notifier);
    return SignUpUsecase(
      logger: logger,
      authStateNotifier: authStateNotifier,
    );
  },
);

/// Logout
final logoutProvider = Provider<LogoutUsecase>(
  (ref) {
    final logger = ref.read(loggerProvider);
    final authStateNotifier = ref.watch(authStateProvider.notifier);
    return LogoutUsecase(
      logger: logger,
      authStateNotifier: authStateNotifier,
    );
  },
);
