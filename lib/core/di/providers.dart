import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/data/datasources/remote/firebase_item_datasource.dart';
import 'package:roadmap/data/repositories/item_repository_impl.dart';
import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/domain/repositories/item_repository.dart';
import 'package:roadmap/domain/usecases/item_usecase.dart';
import 'package:roadmap/presentation/routes/go_router.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';
import 'package:roadmap/presentation/viewmodels/home_viewmodel.dart';
import 'package:roadmap/presentation/viewmodels/splash_viewmodel.dart';

final navigationServiceProvider =
    Provider((ref) => NavigationService(goRouter));

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, SplashState>((ref) {
  final navigationService = ref.read(navigationServiceProvider);
  return SplashViewModel(navigationService);
});

final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
  final usecase = ref.read(itemUsecaseProvider);
  return ItemListNotifier(usecase);
});

final itemUsecaseProvider = Provider<ItemUsecase>((ref) {
  final itemRepository = ref.read(itemRepositoryProvider);
  return ItemUsecase(itemRepository);
});

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final dataSource = ref.read(firebaseItemDataSourceProvider);
  return ItemRepositoryImpl(dataSource);
});

final firebaseItemDataSourceProvider = Provider<FirebaseItemDataSource>((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  return FirebaseItemDataSource(firestore);
});

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
