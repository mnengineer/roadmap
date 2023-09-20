import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/data/datasources/remote/firebase_item_datasource.dart';
import 'package:roadmap/data/repositories/item_repository_impl.dart';
import 'package:roadmap/domain/entities/item_model.dart';
import 'package:roadmap/domain/repositories/item_repository.dart';
import 'package:roadmap/domain/usecases/item_usecase.dart';
import 'package:roadmap/presentation/viewmodels/home_viewmodel.dart';

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
