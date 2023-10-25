import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:roadmap/data/datasources/remote/firebase_item_datasource.dart';
import 'package:roadmap/data/repositories/auth_repository_impl.dart';
import 'package:roadmap/data/repositories/item_repository_impl.dart';
import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/domain/repositories/auth_repository.dart';
import 'package:roadmap/domain/repositories/item_repository.dart';
import 'package:roadmap/domain/usecases/auth_usecase.dart';
import 'package:roadmap/domain/usecases/item_usecase.dart';
import 'package:roadmap/presentation/routes/go_router.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';
import 'package:roadmap/presentation/viewmodels/home_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/login_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/mypage_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/onboarding_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/signup_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/splash_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/welcome_viewmodel.dart';

// Navigation
final navigationServiceProvider =
    Provider((ref) => NavigationService(goRouter));

// ViewModel
final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, SplashState>((ref) {
  final navigationService = ref.read(navigationServiceProvider);
  return SplashViewModel(navigationService);
});

final onboardingViewModelProvider =
    StateNotifierProvider<OnBoardingViewModel, int>((ref) {
  final navigationService = ref.read(navigationServiceProvider);
  return OnBoardingViewModel(navigationService);
});

final welcomeViewModelProvider =
    StateNotifierProvider<WelcomeViewModel, Welcometate>((ref) {
  final navigationService = ref.read(navigationServiceProvider);
  return WelcomeViewModel(navigationService);
});

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>(
  (ref) {
    final navigationService = ref.read(navigationServiceProvider);
    final usecase = ref.read(authUsecaseProvider);
    return LoginViewModel(navigationService, usecase);
  },
);

final signUpViewModelProvider =
    StateNotifierProvider<SignUpViewModel, SignUpState>(
  (ref) {
    final navigationService = ref.read(navigationServiceProvider);
    final usecase = ref.read(authUsecaseProvider);
    return SignUpViewModel(navigationService, usecase);
  },
);

final homeViewModelProvider =
    StateNotifierProvider<HomeViewmodel, AsyncValue<List<Item>>>((ref) {
  final usecase = ref.read(itemUsecaseProvider);
  return HomeViewmodel(usecase);
});

final mypageViewModelProvider =
    StateNotifierProvider<MypageViewmodel, MypageState>((ref) {
  final usecase = ref.read(authUsecaseProvider);
  return MypageViewmodel(usecase);
});

// Usecase
final itemUsecaseProvider = Provider<ItemUsecase>((ref) {
  final itemRepository = ref.read(itemRepositoryProvider);
  return ItemUsecase(itemRepository);
});

final authUsecaseProvider = Provider<AuthUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthUseCase(authRepository);
});

// Repository
final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final dataSource = ref.read(firebaseItemDataSourceProvider);
  return ItemRepositoryImpl(dataSource);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.read(firebaseAuthDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

// DataSource
final firebaseItemDataSourceProvider = Provider<FirebaseItemDataSource>((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final auth = ref.read(firebaseAuthProvider);
  return FirebaseItemDataSource(firestore, auth);
});

final firebaseAuthDataSourceProvider = Provider<FirebaseAuthDatasource>((ref) {
  final firestore = ref.read(firebaseAuthProvider);
  return FirebaseAuthDatasource(firestore);
});

// Firebase
final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
