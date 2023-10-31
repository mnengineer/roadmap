import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/data/datasources/remote/firebase/auth_datasource.dart';
import 'package:roadmap/data/datasources/remote/firebase/goal_item_datasource.dart';
import 'package:roadmap/data/datasources/remote/firebase/roadmap_item_datasource.dart';
import 'package:roadmap/data/repositories/auth_repository_impl.dart';
import 'package:roadmap/data/repositories/goal_item_repository_impl.dart';
import 'package:roadmap/data/repositories/roadmap_item_repository_impl.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/domain/entities/roadmap_item.dart';
import 'package:roadmap/domain/repositories/auth_repository.dart';
import 'package:roadmap/domain/repositories/goal_item_repository.dart';
import 'package:roadmap/domain/repositories/roadmap_item_repository.dart';
import 'package:roadmap/domain/usecases/auth_usecase.dart';
import 'package:roadmap/domain/usecases/goal_item_usecase.dart';
import 'package:roadmap/domain/usecases/roadmap_item_usecase.dart';
import 'package:roadmap/presentation/routes/go_router.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';
import 'package:roadmap/presentation/viewmodels/auth/login_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/auth/signup_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/home/goal/detail_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/home/tabs/home_tab_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/mypage/mypage_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/onboarding/onboarding_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/splash/splash_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/welcome/welcome_viewmodel.dart';

// Widget
final selectedTagProvider = StateProvider<String>((ref) {
  return 'すべて';
});

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
    StateNotifierProvider<WelcomeViewModel, WelcomeState>((ref) {
  final navigationService = ref.read(navigationServiceProvider);
  return WelcomeViewModel(navigationService);
});

final loginViewModelProvider =
    AutoDisposeStateNotifierProvider<LoginViewModel, AsyncValue<void>>(
  (ref) {
    final navigationService = ref.read(navigationServiceProvider);
    final usecase = ref.read(authUsecaseProvider);
    return LoginViewModel(navigationService, usecase);
  },
);

final signUpViewModelProvider =
    AutoDisposeStateNotifierProvider<SignUpViewModel, AsyncValue<void>>(
  (ref) {
    final navigationService = ref.read(navigationServiceProvider);
    final usecase = ref.read(authUsecaseProvider);
    return SignUpViewModel(navigationService, usecase);
  },
);

final homeTabViewModelProvider =
    StateNotifierProvider<HomeTabViewmodel, AsyncValue<List<GoalItem>>>((ref) {
  final navigationService = ref.read(navigationServiceProvider);
  final usecase = ref.read(goalItemUsecaseProvider);
  return HomeTabViewmodel(navigationService, usecase);
});

final detailViewModelProvider =
    StateNotifierProvider<DetailViewmodel, AsyncValue<List<RoadmapItem>>>(
        (ref) {
  final navigationService = ref.read(navigationServiceProvider);
  final usecase = ref.read(roadmapItemUsecaseProvider);
  return DetailViewmodel(navigationService, usecase);
});

final mypageViewModelProvider =
    StateNotifierProvider<MypageViewmodel, MypageState>((ref) {
  final usecase = ref.read(authUsecaseProvider);
  return MypageViewmodel(usecase);
});

// Usecase
final goalItemUsecaseProvider = Provider<GoalItemUsecase>((ref) {
  final repository = ref.read(goalItemRepositoryProvider);
  return GoalItemUsecase(repository);
});

final roadmapItemUsecaseProvider = Provider<RoadmapItemUsecase>((ref) {
  final repository = ref.read(roadmapItemRepositoryProvider);
  return RoadmapItemUsecase(repository);
});

final authUsecaseProvider = Provider<AuthUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return AuthUseCase(repository);
});

// Repository
final goalItemRepositoryProvider = Provider<GoalItemRepository>((ref) {
  final dataSource = ref.read(goalItemDataSourceProvider);
  return GoalItemRepositoryImpl(dataSource);
});

final roadmapItemRepositoryProvider = Provider<RoadmapItemRepository>((ref) {
  final dataSource = ref.read(roadmapItemDataSourceProvider);
  return RoadmapItemRepositoryImpl(dataSource);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.read(firebaseAuthDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

// DataSource
final goalItemDataSourceProvider = Provider<GoalItemDatasource>((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final auth = ref.read(firebaseAuthProvider);
  return GoalItemDatasource(firestore, auth);
});

final roadmapItemDataSourceProvider = Provider<RoadmapItemDatasource>((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final auth = ref.read(firebaseAuthProvider);
  return RoadmapItemDatasource(firestore, auth);
});

final firebaseAuthDataSourceProvider = Provider<AuthDatasource>((ref) {
  final firestore = ref.read(firebaseAuthProvider);
  return AuthDatasource(firestore);
});

// Firebase
final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
